/**
 * EDUAGI EXAMPLE — Quick Start for Students
 *
 * This file shows you how to use EduAGI in your own projects.
 * Copy and modify as needed!
 */

import { EducationalAGI } from './educational-agi-sdk';

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 1: Student Learning Journey
// ═══════════════════════════════════════════════════════════════════════════

async function studentExample() {
  console.log('🎓 Example 1: Student Learning Journey\n');

  // Create SDK
  const eduAGI = new EducationalAGI();

  // Register as student
  const student = eduAGI.registerStudent(
    "Alex Rivera",
    10,  // 10th grade
    'visual'  // Visual learner
  );
  console.log(`✅ Registered: ${student.name}`);

  // Create main learning path
  const pythonPath = eduAGI.createLearningPath(
    "Python Programming",
    "coding",
    4  // Intermediate difficulty
  );
  console.log(`📚 Created path: ${pythonPath.name}`);

  // Add some milestones
  eduAGI.addMilestone(pythonPath.id, {
    id: 'milestone-1',
    name: 'Python Basics',
    description: 'Learn variables, loops, and functions',
    skills_required: ['typing', 'logical thinking'],
    activities: [
      {
        id: 'act-1',
        type: 'lesson',
        content: 'Introduction to Python',
        estimated_time_minutes: 30,
        difficulty: 3,
        ai_assistance_available: true,
        completed: false
      },
      {
        id: 'act-2',
        type: 'exercise',
        content: 'Write your first program',
        estimated_time_minutes: 45,
        difficulty: 4,
        ai_assistance_available: true,
        completed: false
      },
      {
        id: 'act-3',
        type: 'quiz',
        content: 'Python basics assessment',
        estimated_time_minutes: 20,
        difficulty: 4,
        ai_assistance_available: false,
        completed: false
      }
    ],
    completed: false,
    unlocks: ['milestone-2']
  });

  // Complete first activity with good score
  eduAGI.completeActivity(
    student.id,
    pythonPath.id,
    'milestone-1',
    'act-1',
    0.92  // 92% score!
  );
  console.log('✅ Completed first activity with 92%');

  // Get AI help
  const help = await eduAGI.getAIAssistance(
    student.id,
    'coding',
    "What's the difference between a list and a tuple in Python?"
  );
  console.log(`\n🤖 AI Help:\n${help}\n`);

  // Branch into web development
  const webBranch = eduAGI.branchLearningPath(
    pythonPath.id,
    "Web Development",
    "Build websites with Flask"
  );
  console.log(`🌳 Created branch: ${webBranch.name}`);

  // Check progress
  const progress = eduAGI.getProgressReport(student.id);
  console.log('\n📊 Progress Report:');
  console.log(`   Completion: ${(progress.completion_rate * 100).toFixed(1)}%`);
  console.log(`   Learning Velocity: ${progress.learning_velocity.toFixed(2)}x`);
  console.log(`   Strengths: ${progress.strengths.join(', ') || 'Building...'}`);
  console.log(`   Recommendations:`, progress.recommendations);
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 2: Teacher Creating Classroom
// ═══════════════════════════════════════════════════════════════════════════

function teacherExample() {
  console.log('\n\n👨‍🏫 Example 2: Teacher Creating Classroom\n');

  const eduAGI = new EducationalAGI();

  // Create classroom
  const classroom = eduAGI.createClassroom(
    "AP Computer Science A",
    "teacher-123"
  );
  console.log(`✅ Created classroom: ${classroom.name}`);

  // Register students
  const students = [
    eduAGI.registerStudent("Maya Chen", 11, 'reading'),
    eduAGI.registerStudent("Jordan Smith", 11, 'kinesthetic'),
    eduAGI.registerStudent("Sam Taylor", 11, 'visual')
  ];

  // Add students to classroom
  students.forEach(student => {
    eduAGI.addStudentToClassroom(classroom.id, student.id);
    console.log(`   Added: ${student.name}`);
  });

  // Create shared learning path
  const sharedPath = eduAGI.createLearningPath(
    "Data Structures & Algorithms",
    "computer science",
    7  // Advanced
  );
  classroom.shared_paths.push(sharedPath);
  console.log(`📚 Shared path: ${sharedPath.name}`);

  // Create collaboration project
  const project = eduAGI.createCollaborationProject(
    classroom.id,
    "Build a Search Engine",
    "Team project: Implement search algorithms and ranking",
    students.map(s => s.id)
  );
  console.log(`🤝 Project created: ${project.name}`);
  console.log(`   Team: ${students.map(s => s.name).join(', ')}`);
  console.log(`   Main branch: ${project.branches[0].name}`);

  // Post announcement
  classroom.announcements.push({
    id: 'ann-1',
    teacher_id: 'teacher-123',
    title: 'Project Due Date',
    content: 'Search engine project due in 2 weeks. Remember to create branches for your individual contributions!',
    posted_at: Date.now(),
    pinned: true
  });
  console.log(`📢 Posted announcement: ${classroom.announcements[0].title}`);
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 3: Student Collaboration (GitHub-Style)
// ═══════════════════════════════════════════════════════════════════════════

function collaborationExample() {
  console.log('\n\n👥 Example 3: Student Collaboration\n');

  const eduAGI = new EducationalAGI();

  // Create classroom and students
  const classroom = eduAGI.createClassroom("Web Dev Class", "teacher-456");
  const alice = eduAGI.registerStudent("Alice", 10, 'visual');
  const bob = eduAGI.registerStudent("Bob", 10, 'kinesthetic');

  eduAGI.addStudentToClassroom(classroom.id, alice.id);
  eduAGI.addStudentToClassroom(classroom.id, bob.id);

  // Create team project
  const project = eduAGI.createCollaborationProject(
    classroom.id,
    "Build a Todo App",
    "Collaborative project: Create a web-based todo list",
    [alice.id, bob.id]
  );
  console.log(`🚀 Project: ${project.name}`);

  // Alice creates a feature branch
  const aliceBranch: typeof project.branches[0] = {
    id: 'feature-frontend',
    name: 'feature/frontend',
    parent_branch_id: 'main',
    creator_id: alice.id,
    commits: [],
    created_at: Date.now()
  };
  project.branches.push(aliceBranch);
  console.log(`\n🌳 Alice created branch: ${aliceBranch.name}`);

  // Alice commits her work
  aliceBranch.commits.push({
    id: 'commit-1',
    author_id: alice.id,
    message: 'Add HTML structure for todo list',
    changes: [{
      file_path: 'index.html',
      type: 'add',
      content: '<html>...</html>'
    }],
    timestamp: Date.now()
  });
  console.log(`   ✅ Alice committed: "${aliceBranch.commits[0].message}"`);

  // Bob creates his own branch
  const bobBranch: typeof project.branches[0] = {
    id: 'feature-backend',
    name: 'feature/backend',
    parent_branch_id: 'main',
    creator_id: bob.id,
    commits: [],
    created_at: Date.now()
  };
  project.branches.push(bobBranch);
  console.log(`\n🌳 Bob created branch: ${bobBranch.name}`);

  // Bob commits his work
  bobBranch.commits.push({
    id: 'commit-2',
    author_id: bob.id,
    message: 'Add Python Flask backend API',
    changes: [{
      file_path: 'app.py',
      type: 'add',
      content: 'from flask import Flask...'
    }],
    timestamp: Date.now()
  });
  console.log(`   ✅ Bob committed: "${bobBranch.commits[0].message}"`);

  // Alice creates merge request
  const mergeRequest = {
    id: 'mr-1',
    from_branch_id: aliceBranch.id,
    to_branch_id: 'main',
    creator_id: alice.id,
    description: 'Frontend complete! Ready to merge HTML/CSS changes.',
    reviewers: [bob.id],
    status: 'open' as const,
    comments: []
  };
  project.merge_requests.push(mergeRequest);
  console.log(`\n📋 Alice created merge request: #${mergeRequest.id}`);
  console.log(`   From: ${aliceBranch.name} → To: main`);
  console.log(`   Reviewer: Bob`);

  // Bob reviews and comments
  mergeRequest.comments.push({
    id: 'comment-1',
    author_id: bob.id,
    text: 'Looks great! The HTML structure is clean. ✅',
    timestamp: Date.now()
  });
  console.log(`   💬 Bob commented: "${mergeRequest.comments[0].text}"`);

  // Bob approves
  mergeRequest.status = 'approved';
  console.log(`   ✅ Bob approved the merge request`);

  // Merge!
  const mainBranch = project.branches.find(b => b.id === 'main')!;
  mainBranch.commits.push(...aliceBranch.commits);
  mergeRequest.status = 'merged';
  console.log(`   🎉 Merged! ${aliceBranch.name} → main`);

  console.log(`\n📊 Project Status:`);
  console.log(`   Branches: ${project.branches.length}`);
  console.log(`   Commits in main: ${mainBranch.commits.length}`);
  console.log(`   Merge requests: ${project.merge_requests.length}`);
}

// ═══════════════════════════════════════════════════════════════════════════
// EXAMPLE 4: Adaptive Learning in Action
// ═══════════════════════════════════════════════════════════════════════════

function adaptiveLearningExample() {
  console.log('\n\n🎯 Example 4: Adaptive Learning\n');

  const eduAGI = new EducationalAGI();

  const student = eduAGI.registerStudent("Chris", 9, 'kinesthetic');
  const mathPath = eduAGI.createLearningPath("Algebra", "math", 5);

  console.log(`Starting learning velocity: ${student.progress.learning_velocity.toFixed(2)}x`);

  // Add milestone with activities
  eduAGI.addMilestone(mathPath.id, {
    id: 'm1',
    name: 'Linear Equations',
    description: 'Master linear equations',
    skills_required: ['algebra'],
    activities: [
      { id: 'a1', type: 'exercise', content: 'Easy problems', estimated_time_minutes: 20, difficulty: 3, ai_assistance_available: true, completed: false },
      { id: 'a2', type: 'exercise', content: 'Medium problems', estimated_time_minutes: 30, difficulty: 5, ai_assistance_available: true, completed: false },
      { id: 'a3', type: 'exercise', content: 'Hard problems', estimated_time_minutes: 40, difficulty: 7, ai_assistance_available: true, completed: false }
    ],
    completed: false,
    unlocks: []
  });

  // Student struggles with first activity
  console.log('\n📝 Activity 1: Easy problems');
  eduAGI.completeActivity(student.id, mathPath.id, 'm1', 'a1', 0.65);  // 65% - Struggling!
  console.log(`   Score: 65% (struggling)`);
  console.log(`   New velocity: ${student.progress.learning_velocity.toFixed(2)}x (slowed down)`);
  console.log(`   Struggle areas: ${student.progress.struggle_areas.join(', ')}`);

  // Student does better on second try
  console.log('\n📝 Activity 2: Medium problems');
  eduAGI.completeActivity(student.id, mathPath.id, 'm1', 'a2', 0.78);  // 78% - Better!
  console.log(`   Score: 78% (improving)`);
  console.log(`   New velocity: ${student.progress.learning_velocity.toFixed(2)}x`);

  // Student excels!
  console.log('\n📝 Activity 3: Hard problems');
  eduAGI.completeActivity(student.id, mathPath.id, 'm1', 'a3', 0.94);  // 94% - Excellent!
  console.log(`   Score: 94% (excelling!)`);
  console.log(`   New velocity: ${student.progress.learning_velocity.toFixed(2)}x (speeding up)`);
  console.log(`   Strength areas: ${student.progress.strength_areas.join(', ')}`);

  // Get recommendations
  const progress = eduAGI.getProgressReport(student.id);
  console.log(`\n💡 Recommendations:`);
  progress.recommendations.forEach(rec => console.log(`   • ${rec}`));
}

// ═══════════════════════════════════════════════════════════════════════════
// RUN ALL EXAMPLES
// ═══════════════════════════════════════════════════════════════════════════

async function runAllExamples() {
  console.log('═'.repeat(80));
  console.log('🎓 EDUAGI EXAMPLES — Free AI Learning Platform for Students');
  console.log('═'.repeat(80));

  await studentExample();
  teacherExample();
  collaborationExample();
  adaptiveLearningExample();

  console.log('\n' + '═'.repeat(80));
  console.log('✨ Examples complete! Now build your own learning adventures!');
  console.log('═'.repeat(80));
}

// Run if executed directly
if (require.main === module) {
  runAllExamples().catch(console.error);
}

export { runAllExamples };
