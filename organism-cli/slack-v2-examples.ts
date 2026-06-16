/**
 * SLACK AGI V2 — EXAMPLES
 * Complete usage examples for the advanced Slack AI bot
 */

import SlackAGIv2 from './slack-agi-v2';

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 1: Basic Setup
// ═══════════════════════════════════════════════════════════════════════════

async function basicSetup() {
  console.log('🚀 Example 1: Basic Setup\n');

  // Initialize with your webhook
  const slackBot = new SlackAGIv2({
    webhookUrl: 'https://hooks.slack.com/services/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',
    botToken: 'xoxb-your-bot-token', // Optional
    signingSecret: 'your-signing-secret' // Optional
  });

  // Send a simple message
  await slackBot.sendMessage({
    text: '🎉 Slack AGI v2 is now online!'
  });

  // Send a rich message
  await slackBot.sendRichMessage(
    'general',
    '🤖 AI Bot Activated',
    'I\'m ready to help with workflows, automation, and intelligent responses!',
    '#9b59b6'
  );

  console.log('✅ Basic setup complete!\n');
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 2: Custom Workflows
// ═══════════════════════════════════════════════════════════════════════════

function customWorkflows() {
  console.log('🔄 Example 2: Custom Workflows\n');

  const slackBot = new SlackAGIv2({
    webhookUrl: 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'
  });

  // Add custom workflow: Code review reminder
  slackBot.addWorkflow({
    id: 'code-review-reminder',
    name: 'Code Review Reminder',
    type: 'schedule',
    condition: {
      type: 'time',
      schedule: '0 10 * * 1,3,5' // 10 AM on Mon, Wed, Fri
    },
    actions: [
      {
        id: 'review-message',
        type: 'message',
        config: {
          channel: 'engineering',
          message: '👀 Reminder: Please review pending pull requests!\n\n' +
                   '• Check GitHub for open PRs\n' +
                   '• Provide constructive feedback\n' +
                   '• Approve or request changes'
        }
      }
    ],
    enabled: true,
    priority: 7
  });

  // Add custom workflow: Birthday celebrations
  slackBot.addWorkflow({
    id: 'birthday-celebration',
    name: 'Birthday Celebration',
    type: 'event',
    condition: {
      type: 'keyword',
      pattern: 'birthday|bday'
    },
    actions: [
      {
        id: 'birthday-reaction',
        type: 'react',
        config: {
          emoji: 'birthday'
        }
      },
      {
        id: 'birthday-message',
        type: 'message',
        config: {
          channel: 'general',
          message: '🎂🎉 Happy Birthday! 🎉🎂\nWishing you an amazing day filled with joy!'
        },
        delay_seconds: 2
      }
    ],
    enabled: true,
    priority: 8
  });

  // Add custom workflow: Security alert
  slackBot.addWorkflow({
    id: 'security-alert',
    name: 'Security Alert Response',
    type: 'keyword',
    condition: {
      type: 'keyword',
      pattern: 'security|vulnerability|breach|hack|exploit'
    },
    actions: [
      {
        id: 'immediate-react',
        type: 'react',
        config: {
          emoji: 'warning'
        }
      },
      {
        id: 'escalate-security',
        type: 'escalate',
        config: {
          notify: ['security-team', 'cto'],
          message: '🚨 SECURITY ALERT detected in <#CHANNEL>\nImmediate review required!'
        },
        delay_seconds: 1
      },
      {
        id: 'create-incident-thread',
        type: 'thread',
        config: {
          message: '🔒 Security team has been notified. Please provide:\n' +
                   '1. What triggered this alert?\n' +
                   '2. Affected systems\n' +
                   '3. Immediate actions taken\n\n' +
                   'Do NOT share sensitive details in public channels.'
        },
        delay_seconds: 5
      }
    ],
    enabled: true,
    priority: 10
  });

  console.log(`✅ Added ${slackBot.listWorkflows().length} workflows\n`);
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 3: AI Agents in Action
// ═══════════════════════════════════════════════════════════════════════════

async function aiAgentsDemo() {
  console.log('🤖 Example 3: AI Agents\n');

  const slackBot = new SlackAGIv2({
    webhookUrl: 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'
  });

  // Simulate incoming messages and AI responses
  const testMessages = [
    {
      text: 'Hey @bot, how do I deploy the new feature?',
      user: 'U12345',
      channel: 'C67890',
      timestamp: Date.now().toString()
    },
    {
      text: 'Can someone help me debug this error?',
      user: 'U12346',
      channel: 'C67891',
      timestamp: Date.now().toString()
    },
    {
      text: 'What\'s the status of the Q4 project?',
      user: 'U12347',
      channel: 'C67892',
      timestamp: Date.now().toString()
    }
  ];

  for (const message of testMessages) {
    console.log(`📨 Processing: "${message.text}"`);
    await slackBot.processMessage(message);
    console.log('');
  }

  // List all AI agents
  console.log('🤖 Available AI Agents:');
  slackBot.listAIAgents().forEach(agent => {
    console.log(`   • ${agent.name} (${agent.id})`);
    console.log(`     Expertise: ${agent.expertise.join(', ')}`);
    console.log(`     Style: ${agent.responseStyle}`);
  });

  console.log('');
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 4: Channel Analytics
// ═══════════════════════════════════════════════════════════════════════════

async function channelAnalytics() {
  console.log('📊 Example 4: Channel Analytics\n');

  const slackBot = new SlackAGIv2({
    webhookUrl: 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'
  });

  // Simulate channel activity
  const messages = [
    {
      text: 'Great work on the project!',
      user: 'U001',
      channel: 'engineering',
      timestamp: Date.now().toString()
    },
    {
      text: 'We have a critical bug in production',
      user: 'U002',
      channel: 'engineering',
      timestamp: Date.now().toString()
    },
    {
      text: 'Thanks for the help everyone!',
      user: 'U003',
      channel: 'engineering',
      timestamp: Date.now().toString()
    },
    {
      text: 'The deployment was successful',
      user: 'U004',
      channel: 'engineering',
      timestamp: Date.now().toString()
    }
  ];

  for (const msg of messages) {
    await slackBot.processMessage(msg);
  }

  // Get channel stats
  const stats = slackBot.getChannelStats('engineering');

  if (stats) {
    console.log('📈 Engineering Channel Stats:');
    console.log(`   Messages: ${stats.messageCount}`);
    console.log(`   Active Users: ${stats.activeUsers.size}`);
    console.log(`   Sentiment Score: ${stats.sentimentScore.toFixed(2)}`);
    console.log(`   Top Keywords:`);

    // Get top 5 keywords
    const sortedKeywords = Array.from(stats.topKeywords.entries())
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5);

    sortedKeywords.forEach(([word, count]) => {
      console.log(`      • "${word}": ${count} times`);
    });
  }

  console.log('');
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 5: Workflow Testing
// ═══════════════════════════════════════════════════════════════════════════

async function workflowTesting() {
  console.log('🧪 Example 5: Workflow Testing\n');

  const slackBot = new SlackAGIv2({
    webhookUrl: 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'
  });

  // Test urgent escalation workflow
  console.log('Testing urgent escalation workflow...');
  await slackBot.testWorkflow('urgent-escalation', {
    text: 'URGENT: Production server is down!',
    user: 'U12345',
    channel: 'incidents',
    timestamp: Date.now().toString()
  });

  console.log('✅ Workflow test complete\n');

  // Enable/disable workflows
  console.log('Managing workflows:');
  slackBot.disableWorkflow('daily-standup');
  console.log('   ⏸️  Disabled daily standup');

  slackBot.enableWorkflow('daily-standup');
  console.log('   ✅ Re-enabled daily standup\n');
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 6: System Status
// ═══════════════════════════════════════════════════════════════════════════

function systemStatus() {
  console.log('ℹ️  Example 6: System Status\n');

  const slackBot = new SlackAGIv2({
    webhookUrl: 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'
  });

  const status = slackBot.getSystemStatus();

  console.log('🤖 Slack AGI v2 System Status:');
  console.log(`   Workflows: ${status.workflows}`);
  console.log(`   AI Agents: ${status.agents}`);
  console.log(`   Active Channels: ${status.channels}`);
  console.log(`   Total Messages Processed: ${status.totalMessages}`);
  console.log(`   Operating Frequency: ${status.operatingFrequency} Hz (φ-harmonic)`);
  console.log('');
}

// ═══════════════════════════════════════════════════════════════════════════
// RUN ALL EXAMPLES
// ═══════════════════════════════════════════════════════════════════════════

async function runAllExamples() {
  console.log('═'.repeat(80));
  console.log('🚀 SLACK AGI V2 — ADVANCED EXAMPLES');
  console.log('═'.repeat(80));
  console.log('');

  await basicSetup();
  customWorkflows();
  await aiAgentsDemo();
  await channelAnalytics();
  await workflowTesting();
  systemStatus();

  console.log('═'.repeat(80));
  console.log('✨ All examples complete! Now customize for your team!');
  console.log('═'.repeat(80));
}

// Run if executed directly
if (require.main === module) {
  runAllExamples().catch(console.error);
}

export { runAllExamples };
