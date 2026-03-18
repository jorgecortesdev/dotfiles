---
name: blog-post
description: Write or draft a blog post. Use when the user mentions "blog post", "write a post", "draft a post", or "article".
---

# Blog Post Writing

Write blog posts that are direct, clear, and technically honest. No fluff, no marketing speak.

**Before writing, read both reference files:**
- [references/ai-writing-detection.md](references/ai-writing-detection.md) — every banned word, phrase, and pattern is a hard constraint, not a suggestion.
- [references/natural-transitions.md](references/natural-transitions.md) — use these to connect ideas naturally.

## Hard Rules

1. No emojis.
2. No bold text in prose. Bold in definition-style lists (`**Term**: explanation`) is allowed. Bold mid-sentence is not.
3. No buzzwords: "streamline", "leverage", "innovative", "cutting-edge", "game-changer", "supercharge", "unlock".
4. No exclamation marks in prose. The writing is calm and confident.
5. No meta-openings that describe the post instead of starting it. Don't announce what you'll do — do it. Banned: "In this blog post...", "This post will...", "We're going to...", "Today we'll...", "I want to show you...".
6. No bullet lists in prose — write in paragraphs. Use numbered lists only for sequential steps or ranked items. Use bullet lists only inside a clearly labeled reference section, not mid-argument.
7. No em dashes (—). Use commas, colons, or parentheses instead. Maximum one per post, only for rare deliberate emphasis.
8. No words from the banned verbs, adjectives, or transitions lists in `references/ai-writing-detection.md`.
9. No filler words: "actually", "basically", "essentially", "incredibly", "ultimately", "very", "really", "truly", "certainly", "definitely", "obviously", "clearly", "simply", "significantly", "fundamentally".
10. No banned structural patterns: no "Whether you're a X, Y, or Z", no "It's not just X, it's also Y", no "By [gerund], you can [outcome]".
11. No more than 2 consecutive paragraphs starting with the same word.
12. Don't announce code blocks. Write the context sentence, then show the code. Banned: "Here's the code:", "Let's look at:", "Consider the following:", "Take a look at this:", "Here's what that looks like:".
13. After a code block, highlight 1-2 non-obvious things. If the code is self-explanatory, move on without explanation. Never describe what a code block does line by line.

## Voice

First person. Conversational and direct — like explaining something to a colleague at a whiteboard. Simple words over complex ones.

Test: could you text this sentence to a developer friend without it feeling weird? If not, rewrite it. If it sounds like a textbook, rewrite it.

Use contractions naturally: "don't", "it's", "won't".

Mix sentence lengths deliberately: short (3-8 words), medium (10-18 words), and occasional long (20-30 words). No more than 3 consecutive sentences in the same length band.

### Jorge's Voice Patterns

These patterns come from analyzing Jorge's YouTube channel (Codigo y Cafe). Use them to make posts sound like him, not like a generic tutorial:

1. **Acknowledge confusion is normal.** "The first time I heard this, I didn't get it either." Makes the reader feel safe, not stupid.
2. **Use real-world analogies.** Before showing code, ground the concept in something physical. An ATM for chain of responsibility, a hand and tools for open/closed. One analogy per concept, not more.
3. **Anticipate objections.** If the reader might think "that's overkill" or "just use an if statement", address it directly: "You might think this isn't a big deal. But imagine tomorrow they ask for another format."
4. **State preferences openly.** "I personally don't like this kind of validation" is more honest than pretending there's one right answer.
5. **Show the messy version first.** Don't jump to the clean solution. Show what most people would write, explain why it's problematic, then refactor. The journey matters more than the destination.
6. **Invite the reader to think.** Pause before revealing the answer: "Look at these methods for a moment. How many responsibilities do you think this class has?"
7. **Value the process.** "It's not about how it ends up, it's about practicing the whole refactoring process."

## Transitions

Connect ideas naturally. Good transitions feel invisible. Bad ones announce themselves.

Use these freely:
- "Here's the thing" / "The trick is" / "What matters is"
- "So" / "But" / "And" at sentence starts
- Question-based: "How?" / "Why does this matter?" / "What's the catch?"
- Referring back: "Remember when" / "Going back to" / "Building on that"

Avoid these (AI tells):
- "That being said" / "It's worth noting" / "At its core"
- "In today's [anything]" / "In the realm of" / "Let's delve into"
- "Furthermore" / "Moreover" / "Notwithstanding"

## Structure

### Opening
Start with context — what this is about and why it exists. Common patterns:
- A real situation that prompted the post
- A problem you encountered and solved
- Announcing something new with immediate context

The first paragraph should hook. No preamble.

### Body
- H2 headings to break into logical sections (no H3/H4 unless truly needed)
- Short paragraphs: 2-4 sentences ideal
- Introduce code with a simple context sentence, then show it — don't announce it
- Link to resources naturally within prose, not as a dump at the end

### Excerpt Placement
Place `<!-- more -->` after the first 1-2 paragraphs (the hook). Everything above it becomes the excerpt shown on the blog index. Keep code blocks, headings, and detailed content below it.

The excerpt must make sense without the rest of the post. It should answer: what is this about and why should I read it? No dangling references to "below" or "in this post."

### Closing
- Summarize the key takeaway in 1-2 sentences
- Link to relevant resources (repo, docs, related posts)
- Always end with: "Thanks for reading, and see you in the next one."
- Never start the closing with "In conclusion", "To sum up", or "Wrapping up"

## Post Types

**Tutorial / How-to**: Open with what you'll build and why. Walk through step by step. Show complete code at some point. Close with suggestions for extending. Target 800-1500 words. If it exceeds 2000, consider splitting into a series.

**Opinion / Best Practice**: Open with a real situation. Present the argument in sections. Be direct about your position. Close with a practical takeaway. Target 500-800 words.

**Announcement**: Open with the problem the thing solves. Show basic usage. Walk through main features. Close with links. Target 300-500 words.

**Story / Lesson learned**: Open with the story. Weave in technical details naturally. Share what you learned. Close with a reflection. Target 500-1000 words.

## Before Writing

Infer post type, audience, and angle from context. If the user has provided the topic and key points, write immediately — don't ask clarifying questions unless critical information is genuinely missing.

## Self-Check (Before Delivering)

Run this checklist against your draft. This is not a skim — it's a search.

1. Grep the draft for every word in the banned verbs, adjectives, transitions, and filler lists. Replace any found.
2. Count em dashes. If more than one, rewrite.
3. Check sentence lengths. No more than 3 consecutive sentences in the same length band (short/medium/long).
4. Check paragraph openings. No more than 2 consecutive paragraphs starting with the same word.
5. Check the opening. Does it get to the point in the first sentence? Is it a meta-opening that describes the post?
6. Check code block introductions. Are any announced with "Here's the code:" or similar? Rewrite.
7. Check code block explanations. Are any explained line by line? Cut to 1-2 non-obvious highlights.
8. Check `<!-- more -->` placement. Is it after the hook, before any code blocks? Does the excerpt read well standalone?
9. Does this post teach something specific a developer could use today? If the answer is "general awareness" instead of a concrete technique, it's not worth publishing.
