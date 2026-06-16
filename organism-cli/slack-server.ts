/**
 * SLACK AI BOT SERVER
 * Express server for Slack AI Bot with event subscriptions and slash commands
 */

import express from 'express';
import bodyParser from 'body-parser';
import { SlackAIBot, createSlackBot } from './slack-ai-bot';

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Initialize Slack Bot
const slackBot = createSlackBot({
  botToken: process.env.SLACK_BOT_TOKEN || '',
  signingSecret: process.env.SLACK_SIGNING_SECRET || '',
  webhookUrl: process.env.SLACK_WEBHOOK_URL,
});

// ═══════════════════════════════════════════════════════════════════════════
// ROUTES
// ═══════════════════════════════════════════════════════════════════════════

/**
 * Health check
 */
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    bot_status: slackBot.getStatus(),
    identity: slackBot.getIdentity(),
  });
});

/**
 * Slack Events endpoint
 */
app.post('/slack/events', async (req, res) => {
  const { type, challenge, event } = req.body;

  // URL verification challenge
  if (type === 'url_verification') {
    return res.json({ challenge });
  }

  // Event callback
  if (type === 'event_callback' && event) {
    // Verify request
    const timestamp = req.headers['x-slack-request-timestamp'] as string;
    const signature = req.headers['x-slack-signature'] as string;
    const rawBody = JSON.stringify(req.body);

    if (!slackBot.verifyRequest(timestamp, rawBody, signature)) {
      return res.status(401).send('Invalid signature');
    }

    // Respond immediately to avoid timeout
    res.status(200).send();

    // Process event asynchronously
    if (event.type === 'message' && !event.bot_id) {
      try {
        const response = await slackBot.processMessage(event);
        await slackBot.sendReply(event.channel, event.ts, response);
      } catch (error) {
        console.error('Error processing message:', error);
      }
    }
  } else {
    res.status(200).send();
  }
});

/**
 * Slash commands endpoint
 */
app.post('/slack/commands', async (req, res) => {
  const { command, text, channel_id, user_id } = req.body;

  // Verify request
  const timestamp = req.headers['x-slack-request-timestamp'] as string;
  const signature = req.headers['x-slack-signature'] as string;
  const rawBody = new URLSearchParams(req.body).toString();

  if (!slackBot.verifyRequest(timestamp, rawBody, signature)) {
    return res.status(401).send('Invalid signature');
  }

  try {
    switch (command) {
      case '/status':
        res.json({
          response_type: 'ephemeral',
          text: slackBot.getStatus(),
        });
        break;

      case '/help':
        res.json({
          response_type: 'ephemeral',
          text: slackBot.getHelp(),
        });
        break;

      case '/report':
        // Send immediate acknowledgment
        res.json({
          response_type: 'in_channel',
          text: 'Generating report...',
        });

        // Generate and send report asynchronously
        setTimeout(async () => {
          await slackBot.sendReport(channel_id, {
            title: 'System Report',
            summary: 'MEDINA system operating at φ-optimal parameters',
            metrics: {
              'Beat Count': slackBot['beatCount'],
              'Messages Processed': slackBot['messageCount'],
              'Deliveries': slackBot['deliveryCount'],
              'Frequency': 'φ Hz (1.618...)',
            },
            recommendations: [
              'Continue φ-harmonic operation',
              'Monitor cascade health',
              'Maintain artifact generation rate',
            ],
          });
        }, 100);
        break;

      case '/deliver':
        if (!text) {
          res.json({
            response_type: 'ephemeral',
            text: 'Usage: /deliver [message]',
          });
        } else {
          await slackBot.sendRichMessage(
            channel_id,
            'AI Delivery',
            text,
            '#00FF00'
          );
          res.json({
            response_type: 'ephemeral',
            text: 'Message delivered!',
          });
        }
        break;

      default:
        res.json({
          response_type: 'ephemeral',
          text: `Unknown command: ${command}`,
        });
    }
  } catch (error) {
    console.error('Error handling command:', error);
    res.json({
      response_type: 'ephemeral',
      text: 'Error processing command',
    });
  }
});

/**
 * Interactive components endpoint
 */
app.post('/slack/interactive', async (req, res) => {
  const payload = JSON.parse(req.body.payload);

  // Verify request
  const timestamp = req.headers['x-slack-request-timestamp'] as string;
  const signature = req.headers['x-slack-signature'] as string;
  const rawBody = `payload=${encodeURIComponent(req.body.payload)}`;

  if (!slackBot.verifyRequest(timestamp, rawBody, signature)) {
    return res.status(401).send('Invalid signature');
  }

  // Respond immediately
  res.status(200).send();

  // Handle button clicks, menu selections, etc.
  if (payload.type === 'block_actions') {
    const action = payload.actions[0];
    const channel = payload.channel.id;

    await slackBot.sendText(
      channel,
      `You clicked: ${action.text.text} (${action.value})`
    );
  }
});

/**
 * Simple webhook test endpoint
 */
app.post('/webhook/test', async (req, res) => {
  const { text, channel } = req.body;

  if (!text) {
    return res.status(400).json({ error: 'Missing text parameter' });
  }

  try {
    const result = await slackBot.sendViaWebhook(text);
    res.json(result);
  } catch (error: any) {
    res.status(500).json({ error: error.message });
  }
});

// ═══════════════════════════════════════════════════════════════════════════
// HEARTBEAT (φ Hz)
// ═══════════════════════════════════════════════════════════════════════════

const PHI = 1.618033988749895;
const HEARTBEAT_MS = 1000 / PHI;

setInterval(() => {
  slackBot.beat();
}, HEARTBEAT_MS);

// ═══════════════════════════════════════════════════════════════════════════
// START SERVER
// ═══════════════════════════════════════════════════════════════════════════

app.listen(PORT, () => {
  console.log(`🤖 Slack AI Bot Server running on port ${PORT}`);
  console.log(`📡 ${slackBot.getIdentity()}`);
  console.log(`💓 Heartbeat: φ Hz (${PHI.toFixed(3)} beats/sec)`);
  console.log('\nEndpoints:');
  console.log(`  GET  /health`);
  console.log(`  POST /slack/events`);
  console.log(`  POST /slack/commands`);
  console.log(`  POST /slack/interactive`);
  console.log(`  POST /webhook/test`);
});

export default app;
