# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a SwiftUI-based unit converter iOS app built as part of the "100 Days of Swift" learning project. The app converts between different units of measurement including distance, mass, temperature, and time.

## Architecture
- **Single View Architecture**: Uses SwiftUI's ContentView as the main interface
- **State Management**: Uses `@State` properties for reactive UI updates
- **Foundation Framework**: Leverages Foundation's `Measurement` and `Dimension` types for unit conversion calculations
- **MeasurementFormatter**: Handles proper formatting of converted values with appropriate units and localization

## Key Components
- `UnitConverterApp.swift`: Main app entry point with `@main` attribute
- `ContentView.swift`: Main view containing the conversion interface with picker controls, input field, and result display

## Core Functionality
The app uses Foundation's measurement system with predefined unit types:
- Distance: meters, kilometers, feet, yards, miles (UnitLength)
- Mass: grams, kilograms, ounces, pounds (UnitMass)
- Temperature: Celsius, Fahrenheit, Kelvin (UnitTemperature)
- Time: hours, minutes, seconds (UnitDuration)

Conversions are handled automatically by Foundation's `Measurement.converted(to:)` method.

## Development Commands
**Build and Run:**
```bash
# Build the project
xcodebuild -project UnitConverter.xcodeproj -scheme UnitConverter build

# Run in iOS Simulator (requires Xcode)
# Use Xcode IDE or xcodebuild with destination parameter
```

**Testing:**
- No unit tests currently implemented
- Testing is done through iOS Simulator or device

## Xcode Project Configuration
- **Deployment Target**: iOS 26.0
- **Swift Version**: 5.0
- **Bundle ID**: com.antoniogiroz.UnitConverter
- **SwiftUI**: Enabled with previews
- **Automatic Code Signing**: Enabled