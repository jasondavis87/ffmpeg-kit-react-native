# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

React Native wrapper library for FFmpeg Kit, providing FFmpeg and FFprobe capabilities to React Native applications on iOS and Android. Built on top of the ffmpeg-kit project with comprehensive TypeScript support.

## Common Commands

```bash
# Run tests
yarn test

# Run linting
yarn lint

# Release new version (uses release-it with conventional changelog)
yarn release
```

## Architecture

### Core Structure

- **`src/index.js`** - Main JavaScript implementation (~3,300 lines). Contains all exported classes, the native bridge logic, and callback management via NativeEventEmitter.
- **`src/index.d.ts`** - TypeScript type definitions for the entire API.
- **`android/`** - Android native module (Java) in `com.arthenica.ffmpegkit.reactnative` package.
- **`ios/`** - iOS native module (Objective-C) with FFmpegKitReactNativeModule.

### Key Classes

**Session Management:**
- `FFmpegSession` - FFmpeg command execution
- `FFprobeSession` - FFprobe command execution
- `MediaInformationSession` - Media metadata extraction
- `AbstractSession` - Base implementation with shared logic

**Main APIs:**
- `FFmpegKit` - Execute FFmpeg commands (sync/async)
- `FFprobeKit` - Execute FFprobe commands and get media info
- `FFmpegKitConfig` - Global configuration, logging, callbacks, session history

**Data Models:**
- `MediaInformation` / `StreamInformation` / `Chapter` - Parsed media metadata
- `Log` / `Statistics` - Runtime execution data
- `ReturnCode` - Exit code analysis

### Callback System

The library uses in-memory Maps to store session-specific callbacks, with a NativeEventEmitter broadcasting log/statistics/completion events. Sessions are identified by `sessionId` and callbacks are invoked then cleaned up on completion.

### API Patterns

```javascript
// Synchronous (Promise-based)
const session = await FFmpegKit.execute('-i input.mp4 output.mp4');

// Asynchronous with callbacks
FFmpegKit.executeAsync(command, onComplete, onLog, onStatistics);

// Media information
const session = await FFprobeKit.getMediaInformation(path);
const info = session.getMediaInformation();
```

## Platform Requirements

- **Android:** minSdkVersion 24 (16 for LTS), compileSdkVersion 33
- **iOS:** Deployment target 13.0 (10 for LTS)

## Package Variants

Eight package variants available with different codec sets (min, min-gpl, https, https-gpl, audio, video, full, full-gpl). The podspec defaults to `ffmpeg-kit-full-gpl`.
