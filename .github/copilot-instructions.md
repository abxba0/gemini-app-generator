# Copilot Instructions for Gemini App Generator

This repository is an AI-powered application generator that uses Google's Gemini API to create complete, functional applications in various technologies (React, Node.js, Python, full-stack) based on natural language prompts.

## Project Structure

- `scripts/` - Core shell scripts for app generation and Gemini API configuration
  - `app-generator.sh` - Main application generator script with CLI interface
  - `gemini-config.sh` - Configuration script for Gemini API setup
- `Dockerfile` - Multi-language development environment with Node.js, Python, and necessary tools
- `docker-compose.yml` - Development environment orchestration
- `setup.sh` - Automated setup script for the entire system
- `projects/` - Directory where generated applications are created
- `workspace/` - Development workspace mounted in Docker container

## Key Technologies

- **Shell scripting** (Bash) for automation and CLI interfaces
- **Docker** for containerized development environment
- **Google Gemini API** (@google/generative-ai npm package) for AI-powered code generation
- **Node.js** ecosystem tools (npm, create-react-app, Express generator, etc.)
- **Python** ecosystem (Flask, FastAPI, pip)
- **Multiple frameworks**: React, Angular, Vue, Express, Flask, FastAPI

## Architecture & Workflow

1. User provides natural language prompt describing desired application
2. `app-generator.sh` analyzes prompt and determines best technology stack
3. Constructs detailed prompts for Gemini API with specific requirements
4. Gemini generates complete application code with proper file structure
5. System parses response, creates files, and installs dependencies
6. Generated apps are fully functional and ready to run

## Code Generation Patterns

The system uses structured prompts with specific requirements:
- Complete, production-ready code (not templates)
- Proper error handling and validation
- Modern best practices (React hooks, type hints, etc.)
- Responsive design and accessibility
- Comprehensive documentation and comments
- Full dependency management

## Development Guidelines

When working on this codebase:

### Shell Scripts
- Follow existing error handling patterns with colored output
- Use proper quoting and variable expansion
- Maintain compatibility with bash in Docker environment
- Include descriptive help text and usage examples
- Test with various input scenarios

### Docker Configuration
- Keep multi-language support (Node.js, Python, system tools)
- Maintain port mappings for common development servers
- Preserve volume mounts for persistent development
- Include health checks and proper environment variables

### API Integration
- Handle Gemini API errors gracefully with meaningful messages
- Use appropriate temperature and token limits for code generation
- Structure prompts to produce parseable, consistent output
- Include API key validation and configuration checks

### File Processing
- Parse generated code using the `===filename.ext===` delimiter pattern
- Create proper directory structures automatically
- Handle special cases (public/index.html for React, etc.)
- Preserve file permissions and maintain clean output

## Testing Considerations

- Test with various application types and complexity levels
- Verify generated code compiles and runs successfully
- Ensure proper dependency installation across ecosystems
- Validate Docker environment setup and API connectivity
- Check error handling for invalid inputs and API failures

## Common Patterns

- **Colored terminal output**: Use established color constants (RED, GREEN, YELLOW, BLUE)
- **Temporary files**: Use mktemp for secure temporary file creation
- **Error handling**: Exit with proper codes and descriptive messages
- **User feedback**: Provide clear progress indicators and next steps
- **File creation**: Always create parent directories before writing files

## Extension Points

When adding new features:
- Follow the modular function pattern in `app-generator.sh`
- Add new technology stacks by creating `generate_[tech]_app()` functions
- Extend auto-detection logic in `auto_generate_app()`
- Update help text and examples for new capabilities
- Maintain backward compatibility with existing commands

## Security & Best Practices

- Never commit API keys or sensitive configuration
- Validate user inputs before passing to external APIs
- Use secure temporary file creation
- Follow principle of least privilege in Docker setup
- Sanitize generated code output before file creation