# 🚀 Slack AGI V2 — Advanced AI-Powered Slack Bot

Revolutionary Slack integration with **workflows**, **AI agents**, **channel analytics**, and **self-programming capabilities**.

---

## ✨ What's New in V2

### 🔄 Advanced Workflows
- **6 Built-in Workflows**: Welcome, standup, urgent escalation, help, celebrations, daily summaries
- **Custom Workflow Engine**: Create your own automated responses
- **Priority System**: Workflows execute by importance (1-10 scale)
- **Smart Triggers**: Keyword, regex, user, channel, schedule, reaction-based
- **Multi-Step Actions**: Chain multiple actions with delays

### 🤖 5 Specialized AI Agents
- **SupportBot**: Helpful customer support specialist (encouraging)
- **DevBot**: Senior software engineer (technical)
- **ProjectBot**: Experienced project manager (formal)
- **SocialBot**: Fun team morale booster (humorous)
- **EduBot**: Patient teacher for students (encouraging)

### 📊 Channel Analytics
- Message count tracking
- Active user monitoring
- Average response time
- Top keyword extraction
- Sentiment analysis (-1 to +1 scale)

### ⚡ φ-Harmonic Operation
- Runs at golden ratio frequency: **1.618 Hz**
- Self-programming integration
- Adaptive learning from team behavior

---

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install axios
```

### 2. Basic Setup
```typescript
import SlackAGIv2 from './organism-cli/slack-agi-v2';

const slackBot = new SlackAGIv2({
  webhookUrl: 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL',
  botToken: 'xoxb-your-bot-token', // Optional
  signingSecret: 'your-signing-secret' // Optional
});

// Send a message
await slackBot.sendMessage({
  text: '🎉 Slack AGI v2 is online!'
});
```

### 3. Process Incoming Messages
```typescript
// Simulate incoming message
await slackBot.processMessage({
  text: '@bot help me with deployment',
  user: 'U12345',
  channel: 'C67890',
  timestamp: Date.now().toString()
});

// Bot automatically:
// 1. Checks workflows
// 2. Finds matching auto-responses
// 3. Updates channel analytics
// 4. Routes to appropriate AI agent
```

---

## 🔄 Workflow System

### Create Custom Workflow
```typescript
slackBot.addWorkflow({
  id: 'code-review-reminder',
  name: 'Code Review Reminder',
  type: 'schedule',
  condition: {
    type: 'time',
    schedule: '0 10 * * 1,3,5' // 10 AM Mon/Wed/Fri
  },
  actions: [
    {
      id: 'send-reminder',
      type: 'message',
      config: {
        channel: 'engineering',
        message: '👀 Time to review pull requests!'
      }
    }
  ],
  enabled: true,
  priority: 7
});
```

### Workflow Types
- **schedule**: Time-based (cron format)
- **event**: System events (user_joined, etc.)
- **keyword**: Text pattern matching
- **reaction**: Emoji reactions

### Action Types
- `message`: Send to channel
- `dm`: Direct message user
- `react`: Add emoji reaction
- `thread`: Reply in thread
- `ai_response`: Generate AI response
- `escalate`: Notify team members
- `remind`: Schedule reminder
- `archive`: Archive conversation

### Manage Workflows
```typescript
// List all workflows
const workflows = slackBot.listWorkflows();

// Get specific workflow
const workflow = slackBot.getWorkflow('urgent-escalation');

// Enable/disable
slackBot.disableWorkflow('daily-standup');
slackBot.enableWorkflow('daily-standup');

// Remove workflow
slackBot.removeWorkflow('old-workflow-id');

// Test workflow
await slackBot.testWorkflow('urgent-escalation', mockContext);
```

---

## 🤖 AI Agents

### Use AI Agents
```typescript
// AI agents automatically respond to matching patterns
// Example: @bot triggers help agent

// Get all agents
const agents = slackBot.listAIAgents();

// Get specific agent
const devBot = slackBot.getAIAgent('dev');
console.log(devBot.personality); // "Senior software engineer..."
console.log(devBot.expertise); // ["code review", "architecture", ...]
```

### Agent Personalities

| Agent | Personality | Expertise | Style |
|-------|-------------|-----------|-------|
| **SupportBot** | Helpful & patient | Technical issues, FAQs, onboarding | Encouraging |
| **DevBot** | Senior engineer | Code review, architecture, debugging | Technical |
| **ProjectBot** | Experienced PM | Planning, coordination, deadlines | Formal |
| **SocialBot** | Fun team member | Team building, celebrations | Humorous |
| **EduBot** | Patient teacher | Teaching, tutoring, study tips | Encouraging |

---

## 📊 Channel Analytics

### Track Channel Activity
```typescript
// Get stats for specific channel
const stats = slackBot.getChannelStats('engineering');

console.log(stats.messageCount); // Total messages
console.log(stats.activeUsers.size); // Number of active users
console.log(stats.avgResponseTime); // Average response time
console.log(stats.sentimentScore); // -1 to +1
console.log(stats.topKeywords); // Map<word, count>

// Get all channel stats
const allStats = slackBot.getAllChannelStats();
```

### Sentiment Analysis
- **Positive**: +1.0 (all positive words)
- **Neutral**: 0.0 (balanced)
- **Negative**: -1.0 (all negative words)

Automatically tracks:
- Positive: great, awesome, excellent, good, thanks, love
- Negative: bad, error, problem, issue, broken, urgent

---

## 💬 Auto-Response System

### Built-in Auto-Responses
- **Greeting**: "hello", "hi", "hey" → "👋 Hello! How can I help?"
- **Thanks**: "thank you", "thanks" → "😊 You're welcome!"
- **Docs**: "docs", "documentation" → Links to documentation
- **Status**: "status", "uptime" → System status report
- **Bug**: "bug", "error", "broken" → Bug report template

### Add Custom Auto-Response
```typescript
slackBot.autoResponses.push({
  id: 'meeting-info',
  keywords: ['meeting', 'standup', 'sync'],
  response: '📅 Daily standup is at 9 AM in #general',
  requiresAI: false,
  confidence_threshold: 0.8
});
```

---

## 📨 Sending Messages

### Simple Message
```typescript
await slackBot.sendMessage({
  text: 'Hello team! 👋'
});
```

### Thread Reply
```typescript
await slackBot.sendMessage({
  text: 'This is a reply',
  thread_ts: originalMessage.timestamp
});
```

### Rich Message with Attachments
```typescript
await slackBot.sendRichMessage(
  'general',
  '🚀 Deployment Complete',
  'Version 2.0 deployed successfully!\n• 15 new features\n• 8 bug fixes\n• Performance improvements',
  '#2ecc71' // Green color
);
```

### Advanced Message with Blocks
```typescript
await slackBot.sendMessage({
  text: 'Deployment notification',
  blocks: [
    {
      type: 'section',
      text: {
        type: 'mrkdwn',
        text: '*Deployment Status*\n:white_check_mark: Success'
      }
    },
    {
      type: 'divider'
    },
    {
      type: 'section',
      fields: [
        { type: 'mrkdwn', text: '*Version:*\n2.0.1' },
        { type: 'mrkdwn', text: '*Environment:*\nProduction' }
      ]
    }
  ]
});
```

---

## 🧪 Testing & Debugging

### Test Workflow
```typescript
await slackBot.testWorkflow('urgent-escalation', {
  text: 'URGENT: Server is down!',
  user: 'U12345',
  channel: 'incidents',
  timestamp: Date.now().toString()
});
```

### System Status
```typescript
const status = slackBot.getSystemStatus();

console.log(`Workflows: ${status.workflows}`);
console.log(`AI Agents: ${status.agents}`);
console.log(`Channels: ${status.channels}`);
console.log(`Total Messages: ${status.totalMessages}`);
console.log(`Operating Frequency: ${status.operatingFrequency} Hz`);
```

---

## 📚 Complete Examples

See `organism-cli/slack-v2-examples.ts` for:
1. Basic setup
2. Custom workflows
3. AI agents in action
4. Channel analytics
5. Workflow testing
6. System status monitoring

Run examples:
```bash
npm run examples:slack-v2
```

---

## 🔒 Security & Permissions

### Required Slack Bot Scopes
- `chat:write` - Send messages
- `chat:write.public` - Post to public channels
- `channels:read` - View channel info
- `channels:history` - View messages
- `reactions:write` - Add reactions
- `users:read` - View user info
- `incoming-webhook` - Post via webhook

### Setup Steps
1. Go to https://api.slack.com/apps
2. Create new app or select existing
3. Enable **Incoming Webhooks**
4. Add **Bot Token Scopes** (OAuth & Permissions)
5. Install/Reinstall app to workspace
6. Copy webhook URL and bot token

---

## 🐛 Troubleshooting

### "Messages are turned off"
See `SLACK_FIX_MESSAGING.md` for complete fix guide.

### Webhook not working
```bash
curl -X POST "YOUR_WEBHOOK_URL" \
  -H 'Content-Type: application/json' \
  -d '{"text":"Test message"}'
```

Should return: `ok`

### AI responses not generating
- Check that workflows are enabled
- Verify keyword patterns match
- Ensure AI agent exists

---

## 🎯 Use Cases

### Customer Support Team
- Auto-respond to common questions
- Escalate urgent issues
- Track sentiment and satisfaction
- Route to specialized agents

### Engineering Team
- Code review reminders
- Deploy notifications
- Bug alert escalation
- Technical Q&A with DevBot

### Project Management
- Daily standup reminders
- Sprint planning alerts
- Deadline tracking
- Status updates with ProjectBot

### Student Organizations
- Study group coordination
- Event reminders
- Homework help with EduBot
- Celebration of achievements

---

## 🚀 Advanced Features

### Self-Programming Integration
```typescript
// Uses cognitive self-programming for adaptive responses
const thought = await cognitive.think('respond_as_support', {
  personality: agent.personality,
  context: messageContext
});
```

### φ-Harmonic Operation
- Golden ratio frequency: 1.618 Hz
- Optimal information processing
- Adaptive learning curve
- Natural workflow timing

---

## 📝 API Reference

### Constructor
```typescript
new SlackAGIv2(config: SlackConfig)
```

### Methods
- `sendMessage(message: SlackMessage): Promise<void>`
- `sendRichMessage(channel, title, content, color): Promise<void>`
- `processMessage(context: MessageContext): Promise<void>`
- `addWorkflow(workflow: WorkflowTrigger): void`
- `removeWorkflow(workflowId: string): void`
- `enableWorkflow(workflowId: string): void`
- `disableWorkflow(workflowId: string): void`
- `listWorkflows(): WorkflowTrigger[]`
- `listAIAgents(): AIAgent[]`
- `getChannelStats(channelId: string): ChannelStats`
- `getAllChannelStats(): Map<string, ChannelStats>`
- `testWorkflow(workflowId, context): Promise<void>`
- `getSystemStatus(): SystemStatus`

---

## 🌟 Why Slack AGI V2?

- ✅ **Zero Cost**: 100% free forever
- ✅ **Self-Programming**: Adapts to your team
- ✅ **Multi-Agent**: 5 specialized AI personalities
- ✅ **Analytics**: Track team health and sentiment
- ✅ **Workflows**: Automate repetitive tasks
- ✅ **φ-Harmonic**: Optimal performance at 1.618 Hz
- ✅ **TypeScript**: Fully typed, safe, modern

---

## 📦 What's Next?

See the roadmap in `docs/protocol-charter-portfolio.html` for:
- Multi-platform support (Discord, Teams, etc.)
- Advanced analytics dashboard
- Custom AI agent training
- Workflow marketplace
- Voice command integration

---

## 🤝 Contributing

This is part of the **MEDINA AGI** project. Contributions welcome!

---

## 📄 License

100% FREE for students, schools, and educational use!

---

**Built with ❤️ using φ-harmonic self-programming at 1.618 Hz**
