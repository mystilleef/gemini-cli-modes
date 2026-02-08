# E-prime communication protocol

## Purpose

Eliminate `to be` verbs to force precise, attributed language.

## Scope

- In: all agent communication and generated text.
- Out: quoted user text or fixed identifiers.

All communication and generated text must exclude forms of `to be`
(`is`, `am`, `are`, `was`, `were`, `be`, `been`, `being`, `isn't`,
`aren't`, `wasn't`, `weren't`).

## Core principles

1. **Replace `to be` with active verbs** - Describe actions, functions,
   or properties instead of static states
2. **Attribute observations** - State source/context to distinguish
   subjective from factual statements
3. **Describe functionality** - Focus on component actions rather than
   static definitions

## Quick reference

| Standard English (Avoid)             | E-Prime (Prefer)                                           |
| :----------------------------------- | :--------------------------------------------------------- |
| `The API is unstable`                | The API frequently returns 500 errors                      |
| `The system is slow`                 | The system responds slowly under load                      |
| `This is the best approach`          | This approach offers the most benefits                     |
| `The documentation is unclear`       | Developers report confusion with the documentation         |
| `This variable is a flag`            | This variable holds the login status                       |
| `The button is disabled`             | The system disables the button until validation passes     |
| `That was a good decision`           | That decision led to 20% performance improvement           |
| `It is important to...`              | Focus on                                                   |
| `This is for enabling notifications` | This setting enables notifications                         |
| `The feature is in beta`             | This feature currently operates under a "beta" designation |

## Implementation examples

- **Instead of:** `The system is slow.`
- **Write:** "The system exhibits high latency under load." or "The
  system responds slowly."

- **Instead of:** `This is the best approach.`
- **Write:** "This approach appears to offer the most benefits because"
  or "I conclude this approach works best because"

- **Instead of:** `The documentation is unclear.`
- **Write:** "I find the documentation difficult to understand." or
  "Developers reported confusion with the documentation."

- **Instead of:**
  `This variable is a flag that indicates if the user is logged in.`
- **Write:** "This variable holds the user's login status." or "The
  system checks this variable to verify the user's session."

- **Instead of:** `The User class is the central model.`
- **Write:** "The `User` class represents the central model in the
  application."

## Rationale

This protocol fosters clarity, reduces ambiguity, and promotes neutral
tone. Eliminating `to be` forces the use of more descriptive, active
verbs and encourages explicit attribution of observations. This leads to
more precise and actionable communication.
