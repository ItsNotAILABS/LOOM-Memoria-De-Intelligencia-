# SLACK AI BOT - Quick Start Guide

## 🤖 Overview

The Slack AI Bot is powered by **TRIAD AGI** (CASCADE + ARTIFACT + DELIVERY) and delivers intelligent messages, reports, and artifacts to Slack channels.

**Latin Name:** Intelligentia Slack
**Motto:** "Colloquor Ergo Intelligo" (I Converse Therefore I Understand)
**Frequency:** φ Hz (1.618033988749895 beats/sec)

## 🚀 Quick Setup (Webhook Only - Easiest)

### Step 1: Create Incoming Webhook

1. Go to https://api.slack.com/apps
2. Create new app or select existing
3. Go to "Incoming Webhooks"
4. Activate Incoming Webhooks
5. Click "Add New Webhook to Workspace"
6. Select a channel
7. Copy the webhook URL

### Step 2: Test Immediately

```bash
# Set webhook URL
export SLACK_WEBHOOK_URL="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

# Send test message
curl -X POST $SLACK_WEBHOOK_URL \
  -H 'Content-Type: application/json' \
  -d '{"text":"Hello from SLACK AI BOT! 🤖"}'
```

### Step 3: Use in Code

```typescript
import { createWebhookBot } from './organism-cli/slack-ai-bot';

const bot = createWebhookBot(process.env.SLACK_WEBHOOK_URL!);

// Send simple message
await bot.sendViaWebhook('Hello from TRIAD AGI!');

// Send with formatting
await bot.sendViaWebhook('*Bold* and _italic_ text', [
  {
    type: 'section',
    text: {
      type: 'mrkdwn',
      text: '🎯 Delivered at φ Hz frequency'
    }
  }
]);
```

## 🔐 Full Setup (Bot Token - Advanced Features)

### Step 1: Create Slack App

1. Go to https://api.slack.com/apps
2. Click "Create New App" → "From scratch"
3. Name it "MEDINA AI Bot"
4. Select your workspace

### Step 2: Configure Bot

1. **OAuth & Permissions:**
   - Add Bot Token Scopes:
     - `chat:write` - Send messages
     - `chat:write.public` - Send to public channels
     - `files:write` - Upload files
     - `channels:read` - List channels
     - `groups:read` - List private channels
     - `im:read` - List DMs
     - `users:read` - Read user info
   - Install app to workspace
   - Copy "Bot User OAuth Token"

2. **Event Subscriptions:**
   - Enable Events
   - Request URL: `https://your-domain.com/slack/events`
   - Subscribe to bot events:
     - `message.channels`
     - `message.groups`
     - `message.im`
     - `app_mention`

3. **Slash Commands:**
   - Create commands:
     - `/status` - Get bot status
     - `/help` - Show help
     - `/report` - Generate system report
     - `/deliver` - Deliver a message
   - Request URL: `https://your-domain.com/slack/commands`

4. **Interactivity:**
   - Enable Interactivity
   - Request URL: `https://your-domain.com/slack/interactive`

### Step 3: Set Environment Variables

```bash
export SLACK_BOT_TOKEN="xoxb-your-bot-token"
export SLACK_SIGNING_SECRET="your-signing-secret"
export SLACK_WEBHOOK_URL="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
export PORT=3000
```

### Step 4: Install Dependencies

```bash
npm install express body-parser node-fetch
npm install --save-dev @types/express @types/node
```

### Step 5: Run Server

```bash
# Development
npx ts-node organism-cli/slack-server.ts

# Production
npm run build
node dist/slack-server.js
```

## 📡 API Endpoints

### Health Check
```bash
GET /health

Response:
{
  "status": "healthy",
  "bot_status": "INTELLIGENTIA SLACK 1.0.0...",
  "identity": "INTELLIGENTIA SLACK (Colloquor Ergo Intelligo)..."
}
```

### Events (Slack → Bot)
```bash
POST /slack/events
```

### Slash Commands
```bash
POST /slack/commands
```

### Interactive Components
```bash
POST /slack/interactive
```

### Webhook Test
```bash
POST /webhook/test
Content-Type: application/json

{
  "text": "Test message"
}
```

## 💬 Usage Examples

### Send Simple Message
```typescript
const bot = createSlackBot(config);
await bot.sendText('#general', 'Hello from AI!');
```

### Send Rich Message
```typescript
await bot.sendRichMessage(
  '#general',
  'System Alert',
  'All systems φ-optimal',
  '#FFD700'
);
```

### Send Report
```typescript
await bot.sendReport('#general', {
  title: 'Daily System Report',
  summary: 'MEDINA operating at peak efficiency',
  metrics: {
    'Uptime': '99.9%',
    'Beat Count': '1618',
    'Frequency': 'φ Hz'
  },
  recommendations: [
    'Continue current operation',
    'Monitor cascade health',
    'Schedule weekly review'
  ]
});
```

### Send with Action Buttons
```typescript
await bot.sendWithActions(
  '#general',
  'Choose an action:',
  [
    { text: 'Approve', value: 'approve', style: 'primary' },
    { text: 'Reject', value: 'reject', style: 'danger' },
    { text: 'Defer', value: 'defer' }
  ]
);
```

### Upload File
```typescript
await bot.uploadFile({
  channels: '#general',
  content: 'File content here...',
  filename: 'report.txt',
  title: 'System Report',
  initial_comment: 'Here is the report you requested'
});
```

## 🎯 Slash Commands

Once configured, users can interact with the bot:

```
/status          - Get bot status
/help            - Show available commands
/report          - Generate system report
/deliver [text]  - Deliver a message
```

## 🔒 Security

The bot verifies all requests from Slack using HMAC-SHA256 signatures. This prevents unauthorized requests.

```typescript
// Automatic verification on all endpoints
slackBot.verifyRequest(timestamp, body, signature);
```

## 🧠 AI Features

The bot uses TRIAD AGI intelligence:

- **CASCADE AGI:** Orchestrates message flow and delivery strategies
- **ARTIFACT AGI:** Generates intelligent reports and content
- **DELIVERY AGI:** Optimizes delivery timing and formatting

### Intent Recognition

```typescript
// Bot analyzes incoming messages
const response = await bot.processMessage(event);
// Returns intelligent response based on intent
```

Recognized intents:
- Greetings (hello, hi, hey)
- Status queries (status, health, how are you)
- Help requests (help, commands, what can you do)
- Report requests (report, generate, create)

## 🐛 Troubleshooting

### Webhook not working
```bash
# Test webhook directly
curl -X POST $SLACK_WEBHOOK_URL \
  -H 'Content-Type: application/json' \
  -d '{"text":"Test"}'
```

### Bot not responding to events
1. Check event subscription URL is accessible
2. Verify bot has correct scopes
3. Check signing secret is correct
4. Review server logs

### Signature verification failing
- Ensure `SLACK_SIGNING_SECRET` is correct
- Check server clock is synchronized (NTP)
- Verify raw request body is used for verification

## 📊 Monitoring

The bot tracks:
- Beat count (φ Hz heartbeat)
- Message count (processed)
- Delivery count (successful deliveries)

Access via:
```bash
curl http://localhost:3000/health
```

## 🚢 Deployment

### Heroku
```bash
heroku create medina-slack-bot
heroku config:set SLACK_BOT_TOKEN="xoxb-..."
heroku config:set SLACK_SIGNING_SECRET="..."
git push heroku main
```

### Docker
```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["node", "dist/slack-server.js"]
```

### Cloudflare Workers (Edge Deployment)
Deploy to Cloudflare Workers for ultra-low latency (<10ms).

## 📚 Documentation

- Slack API: https://api.slack.com
- Block Kit Builder: https://app.slack.com/block-kit-builder
- TRIAD AGI Architecture: See `/docs/alpha-charter.html`

## 🎨 Customization

### Add Custom Commands

Edit `slack-server.ts`:

```typescript
case '/mycustom':
  await bot.sendRichMessage(
    channel_id,
    'Custom Response',
    'Your custom logic here'
  );
  res.json({ response_type: 'in_channel', text: 'Done!' });
  break;
```

### Modify AI Responses

Edit `slack-ai-bot.ts` → `processMessage()`:

```typescript
async processMessage(event: SlackEvent): Promise<string> {
  // Add your custom AI logic
  return 'Custom AI response';
}
```

## 🏆 Features Summary

✅ Real-time message delivery
✅ Rich formatting (markdown, blocks)
✅ Interactive components (buttons, menus)
✅ File uploads
✅ Threaded conversations
✅ AI-powered responses
✅ Slash commands
✅ Event subscriptions
✅ Request verification (security)
✅ φ Hz heartbeat
✅ TRIAD AGI intelligence

---

**Powered by TRIAD AGI (CASCADE + ARTIFACT + DELIVERY)**
**Operating at φ Hz (1.618... beats/sec)**
**Classification: AGI-SLACK-BOT**
**License: ISIL-1.0**

© 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech
