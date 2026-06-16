# 🎓 EduAGI PWA — AI Learning Platform

**Fully installable Progressive Web App** for students with GitHub-style learning paths, 5 AI tutors, and adaptive learning.

---

## ✨ What Makes EduAGI PWA Special?

### 📱 Progressive Web App Features
- **Fully Installable**: Download as real app on mobile & desktop
- **Works Offline**: Learn anywhere, even without internet
- **Background Sync**: Progress syncs when back online
- **Push Notifications**: Get notified of new milestones
- **Fast & Responsive**: Optimized for all devices
- **No App Store**: Install directly from browser

### 🌳 GitHub-Style Learning
- **Branch & Explore**: Create learning branches like code branches
- **Merge Knowledge**: Combine learning paths
- **Commits & Progress**: Track every milestone
- **Collaboration**: Work with classmates on projects
- **Pull Requests**: Review each other's work

### 🤖 5 AI Tutors
- **CodeMentor** 👨‍💻: Programming & algorithms (casual, encouraging)
- **MathBot** 🔢: Math & problem-solving (analytical, patient)
- **WriteWise** ✍️: Writing & communication (socratic, insightful)
- **SciExplorer** 🔬: Science & discovery (curious, enthusiastic)
- **StudyBuddy** 📖: Study skills & organization (supportive, practical)

### 🎯 Adaptive Learning
- Adjusts difficulty using φ ratio (1.618)
- Tracks learning velocity in real-time
- Identifies strengths and struggles
- Provides personalized recommendations
- Gamification with badges and streaks

---

## 🚀 Quick Start

### 1. Install the App

#### On Mobile (iOS/Android):
1. Open `docs/eduagi-pwa.html` in Safari/Chrome
2. Tap **Share** button
3. Select **"Add to Home Screen"**
4. Tap **"Add"**
5. App icon appears on home screen!

#### On Desktop (Chrome/Edge):
1. Open `docs/eduagi-pwa.html` in browser
2. Click **"Install App"** button (top right)
3. Click **"Install"** in popup
4. App opens in standalone window!

### 2. Create Your Profile
- Enter your name
- Select grade level
- Choose learning style (visual, reading, kinesthetic)
- Start learning!

### 3. Choose Your Path
- Browse available learning paths
- Start with main path
- Branch out to explore topics
- Merge knowledge back to main

---

## 📚 Learning Paths

### Main Path
Your primary learning journey. Example:
- **Python Programming**: Master Python from basics to advanced

### Branches
Explore specific topics without losing main progress:
- **Web Development**: Build websites with Flask
- **Data Science**: Analyze data with pandas
- **Game Development**: Create games with Pygame

### How It Works
```
Main: Python Programming (65% complete)
  ├── Branch: Web Development (30% complete)
  ├── Branch: Data Science (15% complete)
  └── Branch: Game Development (0% complete)
```

You can:
- Work on multiple branches simultaneously
- Return to main path anytime
- Merge completed branches
- Archive finished branches

---

## 🤖 AI Tutors

### CodeMentor 👨‍💻
**Personality**: Encouraging tech mentor
**Expertise**: Python, JavaScript, algorithms, debugging
**Style**: Casual and supportive
**Best For**: Programming questions, code review

**Example Chat**:
```
You: How do I write a for loop in Python?

CodeMentor: Great question! 🚀 For loops in Python
are super powerful. Here's the basic syntax:

for item in sequence:
    # do something with item

Want to try an example together?
```

### MathBot 🔢
**Personality**: Analytical mathematician
**Expertise**: Algebra, geometry, calculus, statistics
**Style**: Patient and methodical
**Best For**: Math problems, step-by-step solutions

**Example Chat**:
```
You: Help me solve: 2x + 5 = 13

MathBot: Let's solve this step by step:

1. Start: 2x + 5 = 13
2. Subtract 5 from both sides: 2x = 8
3. Divide by 2: x = 4

Check: 2(4) + 5 = 8 + 5 = 13 ✓

Makes sense?
```

### WriteWise ✍️
**Personality**: Insightful writing coach
**Expertise**: Essays, creative writing, grammar
**Style**: Socratic and thought-provoking
**Best For**: Writing assignments, editing

**Example Chat**:
```
You: How can I improve my essay introduction?

WriteWise: Great question! What's your essay about?
And what feeling do you want readers to have after
reading your introduction? Let's think about:

1. Hook - What grabs attention?
2. Context - What background do they need?
3. Thesis - What's your main argument?
```

### SciExplorer 🔬
**Personality**: Curious scientist
**Expertise**: Physics, chemistry, biology, earth science
**Style**: Enthusiastic and hands-on
**Best For**: Science concepts, experiments

**Example Chat**:
```
You: Why is the sky blue?

SciExplorer: Ooh, great question! 🔬 This is all
about light and particles. When sunlight enters
our atmosphere, it collides with air molecules.
Blue light has shorter wavelengths, so it scatters
more than other colors. That's why we see blue!

Want to know what happens at sunset? 🌅
```

### StudyBuddy 📖
**Personality**: Supportive study partner
**Expertise**: Study techniques, time management, test prep
**Style**: Practical and motivating
**Best For**: Study planning, exam prep

**Example Chat**:
```
You: I have a big test next week. Help!

StudyBuddy: You got this! 💪 Let's make a plan:

1. What subject is the test?
2. How many days until the test?
3. What topics are you confident about?
4. What topics need more work?

We'll create a study schedule together!
```

---

## 📊 Progress Tracking

### Dashboard Stats
- **Completion Rate**: Overall progress percentage
- **Learning Velocity**: Speed of learning (1.0x = normal)
- **Badges Earned**: Achievements unlocked
- **Day Streak**: Consecutive days of learning

### Learning Velocity
- **< 0.8x**: Struggling, needs support
- **0.8-1.2x**: Normal pace
- **> 1.2x**: Excelling, ready for challenges

### Badges System
- 🌱 **First Steps**: Complete first activity
- 🔥 **Week Streak**: 7 days in a row
- 🏆 **Path Complete**: Finish learning path
- 🌟 **Perfect Score**: 100% on activity
- 🚀 **Fast Learner**: 1.5x velocity
- 🎓 **Scholar**: 10 paths completed
- 🤝 **Team Player**: Collaborate on project
- 💎 **Master**: Expert in 3+ subjects

---

## 👥 Collaboration Features

### Classrooms
Teachers can create virtual classrooms:
- Add students
- Assign shared learning paths
- Track class progress
- Post announcements

### Team Projects
GitHub-style collaboration:
- **Main Branch**: Project foundation
- **Feature Branches**: Individual contributions
- **Commits**: Save your work
- **Merge Requests**: Propose changes
- **Code Reviews**: Peer feedback
- **Merge**: Combine everyone's work

**Example Project Flow**:
```
Project: Build a Todo App

Main Branch
  ├── Alice's Branch: Frontend (HTML/CSS)
  │   └── Commits: "Add structure", "Style buttons"
  └── Bob's Branch: Backend (Python/Flask)
      └── Commits: "Create API", "Add database"

Alice creates merge request → Bob reviews → Approved → Merged!
```

---

## 🔄 Adaptive Learning

### How It Works
1. **Start Activity**: Begin with estimated difficulty
2. **Complete Activity**: Submit with score
3. **AI Analyzes**: Evaluates performance
4. **Adjusts Path**: Modifies future difficulty using φ ratio
5. **Provides Feedback**: Suggests next steps

### Performance Tracking
- **Struggle Areas**: Topics needing review
- **Strength Areas**: Mastered concepts
- **Recommendations**: Personalized next steps
- **Learning Patterns**: When you learn best

### φ-Harmonic Adjustment
Uses golden ratio (1.618) for optimal difficulty:
- **Too easy** → Increase by φ factor
- **Too hard** → Decrease by φ factor
- **Just right** → Maintain current level

---

## 📱 PWA Features

### Install & Use Offline
1. Install app (see Quick Start)
2. Download learning content
3. Use offline anywhere
4. Progress syncs when online

### Background Sync
- Saves progress locally
- Queues updates
- Syncs automatically when connected
- Never lose your work!

### Push Notifications
Get notified about:
- New milestones unlocked
- Streak reminders
- Classmate messages
- Teacher announcements
- Achievement badges

### Home Screen Shortcuts
Long-press app icon:
- **My Learning Paths** → Jump to paths
- **AI Tutors** → Open chat
- **Progress** → View dashboard

---

## 🎨 Customization

### Learning Styles
- **Visual**: Diagrams, videos, infographics
- **Reading**: Text, articles, explanations
- **Kinesthetic**: Interactive, hands-on, practice

### Themes
- Purple gradient (default)
- Dark mode (coming soon)
- High contrast (coming soon)

### Preferences
- Notification settings
- AI tutor personality
- Difficulty preference
- Language (coming soon)

---

## 🔒 Privacy & Security

### FERPA Compliant
- Student data stays private
- No tracking or ads
- Offline-first architecture
- Optional parent dashboard

### Data Storage
- **Local**: IndexedDB for offline data
- **Cloud**: Encrypted sync (optional)
- **Ownership**: You control your data
- **Export**: Download anytime

### Free Forever
- No premium tiers
- No hidden costs
- No ads
- 100% free for students and schools

---

## 🛠️ Technical Details

### Built With
- **Frontend**: HTML5, CSS3, JavaScript
- **PWA**: Service Workers, Web App Manifest
- **Storage**: IndexedDB for offline
- **Architecture**: φ-harmonic self-programming
- **SDK**: Educational AGI SDK (`educational-agi-sdk.ts`)

### Browser Support
- ✅ Chrome 90+
- ✅ Safari 15+
- ✅ Firefox 88+
- ✅ Edge 90+
- ✅ Samsung Internet 14+

### Device Support
- ✅ iOS 15+ (iPhone, iPad)
- ✅ Android 9+
- ✅ Windows 10+
- ✅ macOS 11+
- ✅ Linux (Chrome/Firefox)

### Performance
- **First Load**: < 2 seconds
- **Offline Load**: < 500ms
- **Cache Size**: ~5 MB
- **Updates**: Background auto-update

---

## 📚 Examples & Tutorials

See `organism-cli/eduagi-examples.ts` for:
1. Student learning journey
2. Teacher classroom setup
3. GitHub-style collaboration
4. Adaptive learning in action

View live demo:
```bash
open docs/eduagi-pwa.html
```

Or visit: `docs/eduagi-demo.html` for the original demo.

---

## 🎯 Use Cases

### Individual Students
- Self-paced learning
- Homework help from AI tutors
- Track your own progress
- Explore topics freely

### Classrooms
- Teacher-managed learning paths
- Class-wide projects
- Peer collaboration
- Shared achievements

### Homeschooling
- Parent-guided curriculum
- Flexible pacing
- Multi-student support
- Progress reports

### Study Groups
- Collaborative learning
- Shared projects
- Group chat with AI tutors
- Team achievements

---

## 🚀 Future Features

### Coming Soon
- Voice commands for AI tutors
- Augmented reality lessons
- Multi-language support
- Parent/teacher dashboard
- Advanced analytics
- Custom learning path creator
- Peer-to-peer learning matches
- Virtual study rooms

### Roadmap
See `docs/protocol-charter-portfolio.html` for full roadmap.

---

## 🐛 Troubleshooting

### App Won't Install
- **iOS**: Use Safari (not Chrome)
- **Android**: Use Chrome (not Firefox)
- **Desktop**: Use Chrome or Edge

### Offline Not Working
1. Check service worker registered
2. Open DevTools → Application → Service Workers
3. Clear cache and reload
4. Try again

### Sync Issues
1. Check internet connection
2. Open app and wait 10 seconds
3. Check DevTools → Console for errors
4. Try manual sync (Settings → Sync Now)

### AI Tutors Not Responding
- Check internet (AI requires connection)
- Wait 2-3 seconds for response
- Try different tutor
- Refresh app

---

## 📖 SDK Documentation

For developers integrating the SDK:
- See `EDUAGI_README.md` for API reference
- See `organism-cli/educational-agi-sdk.ts` for source
- See `organism-cli/eduagi-examples.ts` for examples

---

## 🌟 Why EduAGI PWA?

- ✅ **100% Free**: No cost, ever
- ✅ **Installable**: Real app experience
- ✅ **Offline**: Learn anywhere
- ✅ **AI-Powered**: 5 specialized tutors
- ✅ **Adaptive**: Personalized difficulty
- ✅ **Collaborative**: GitHub-style projects
- ✅ **Beautiful**: Modern, responsive design
- ✅ **Privacy-First**: Your data, your control
- ✅ **No Ads**: Pure learning experience
- ✅ **Cross-Platform**: Works everywhere

---

## 🤝 Contributing

Part of the **MEDINA AGI** project. We welcome:
- Bug reports
- Feature requests
- Translation contributions
- Content creation
- UI/UX improvements

---

## 📄 License

**100% FREE** for students, teachers, and educational institutions!

---

## 🎓 About

EduAGI is an AI-powered learning platform designed to train the next generation through adaptive, collaborative, and creative education—**not the traditional rigid school system**.

Built with **φ-harmonic self-programming** at **1.618 Hz** for optimal learning experiences.

---

**Learn smarter, not harder. 🚀**

**Built with ❤️ for students everywhere**
