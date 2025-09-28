# Contributing to Gemini App Generator

Thank you for your interest in contributing to the Gemini App Generator! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Ways to Contribute

1. **Bug Reports**: Report issues and bugs
2. **Feature Requests**: Suggest new features and improvements
3. **Code Contributions**: Submit bug fixes and new features
4. **Documentation**: Improve documentation and examples
5. **Testing**: Help test new features and report feedback
6. **Community Support**: Help other users in discussions

### Before You Start

- Check existing [issues](../../issues) and [pull requests](../../pulls)
- Read the [README](README.md) and [documentation](docs/)
- Set up the development environment
- Familiarize yourself with the codebase

## 🛠 Development Setup

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/)
- [Google AI API Key](https://makersuite.google.com/app/apikey)
- Text editor or IDE

### Setup Steps

1. **Fork the Repository**
   ```bash
   # Fork on GitHub, then clone your fork
   git clone https://github.com/YOUR_USERNAME/gemini-app-generator.git
   cd gemini-app-generator
   ```

2. **Set Up Environment**
   ```bash
   # Copy environment template
   cp .env.example .env
   
   # Add your API key to .env
   echo "GEMINI_API_KEY=your-api-key-here" >> .env
   ```

3. **Run Setup**
   ```bash
   ./setup.sh
   ```

4. **Verify Installation**
   ```bash
   docker-compose exec gemini-dev app-generator.sh help
   ```

### Development Workflow

1. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-number
   ```

2. **Make Changes**
   - Edit files in your preferred editor
   - Follow the coding standards (see below)
   - Test your changes thoroughly

3. **Test Changes**
   ```bash
   # Syntax check for shell scripts
   bash -n setup.sh
   bash -n scripts/app-generator.sh
   bash -n scripts/gemini-config.sh
   
   # Test functionality
   docker-compose exec gemini-dev app-generator.sh generate "test app"
   ```

4. **Commit Changes**
   ```bash
   git add .
   git commit -m "feat: add new feature" # or "fix: resolve issue"
   ```

5. **Push and Create PR**
   ```bash
   git push origin feature/your-feature-name
   # Create pull request on GitHub
   ```

## 📋 Coding Standards

### Shell Scripts

#### Style Guidelines

- Use 4-space indentation
- Use meaningful variable names
- Add comments for complex logic
- Use double quotes for variables: `"$variable"`
- Use `#!/bin/bash` shebang
- Follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)

#### Error Handling

```bash
# Always check for errors
if ! command_that_might_fail; then
    echo "Error: Command failed" >&2
    exit 1
fi

# Use proper exit codes
exit 0  # Success
exit 1  # General error
exit 2  # Misuse of shell builtins
```

#### Function Structure

```bash
function_name() {
    local param1="$1"
    local param2="$2"
    
    # Validate parameters
    if [[ -z "$param1" ]]; then
        echo "Error: Parameter required" >&2
        return 1
    fi
    
    # Function logic here
    echo "Success message"
    return 0
}
```

### Documentation

#### Markdown Style

- Use clear, concise language
- Include code examples
- Use proper heading hierarchy
- Add table of contents for long documents
- Keep lines under 80 characters when possible

#### Code Comments

```bash
# Single-line comment for brief explanations

# Multi-line comment for complex logic:
# This function does something complex
# It takes multiple parameters and processes them
# Returns 0 on success, 1 on failure
```

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Format
type(scope): description

# Types
feat: new feature
fix: bug fix
docs: documentation changes
style: formatting changes
refactor: code restructuring
test: adding/updating tests
chore: maintenance tasks

# Examples
feat(generator): add Vue.js support
fix(api): handle rate limit errors
docs(readme): update installation guide
style(scripts): improve code formatting
```

## 🧪 Testing

### Manual Testing

1. **Basic Functionality**
   ```bash
   # Test help command
   app-generator.sh help
   
   # Test generation
   app-generator.sh generate "simple test app"
   
   # Test listing
   app-generator.sh list
   
   # Test cleanup
   app-generator.sh clean
   ```

2. **Framework Testing**
   ```bash
   # Test each framework
   app-generator.sh generate "React todo app" react test-react
   app-generator.sh generate "Node API" node test-node
   app-generator.sh generate "Vue dashboard" vue test-vue
   app-generator.sh generate "Python web app" python test-python
   ```

3. **Edge Cases**
   ```bash
   # Test error handling
   app-generator.sh generate ""  # Empty prompt
   app-generator.sh generate "test" invalid-type  # Invalid type
   
   # Test special characters
   app-generator.sh generate "app with special chars!@#"
   ```

### Automated Testing

Currently, testing is primarily manual. We welcome contributions for:
- Unit tests for shell functions
- Integration tests for generation workflow
- API mocking for offline testing
- Continuous integration setup

### Testing Checklist

Before submitting changes:

- [ ] Shell scripts pass syntax check (`bash -n script.sh`)
- [ ] All supported app types generate successfully
- [ ] Error handling works correctly
- [ ] Documentation is updated
- [ ] Examples work as described
- [ ] No security vulnerabilities introduced
- [ ] Container builds successfully
- [ ] API integration functions properly

## 📝 Documentation

### Areas Needing Documentation

- API reference completion
- Tutorial videos
- Architecture diagrams
- Performance optimization guides
- Deployment instructions
- Troubleshooting scenarios

### Documentation Standards

- Keep documentation up-to-date with code changes
- Include practical examples
- Use clear, beginner-friendly language
- Add screenshots for UI-related changes
- Cross-reference related sections

## 🐛 Bug Reports

### Bug Report Template

```markdown
**Bug Description**
A clear description of the bug.

**Steps to Reproduce**
1. Run command...
2. See error...

**Expected Behavior**
What should have happened.

**Actual Behavior**  
What actually happened.

**Environment**
- OS: [e.g., Ubuntu 20.04]
- Docker version: [e.g., 20.10.7]
- Container logs: [paste relevant logs]

**Additional Context**
Any other relevant information.
```

### Before Reporting

1. Check existing issues
2. Try to reproduce consistently
3. Test with minimal example
4. Gather system information
5. Check logs for error details

## 💡 Feature Requests

### Feature Request Template

```markdown
**Feature Description**
Clear description of the proposed feature.

**Use Case**
Why is this feature needed? What problem does it solve?

**Proposed Solution**
How should this feature work?

**Alternatives Considered**
Other approaches you've considered.

**Additional Context**
Any other relevant information, mockups, or examples.
```

### Feature Evaluation Criteria

- Alignment with project goals
- User benefit and demand
- Implementation complexity
- Maintenance burden
- Security implications
- Performance impact

## 🏗 Architecture Contributions

### Adding New Framework Support

1. **Create Generator Function**
   ```bash
   generate_newframework_app() {
       local prompt="$1"
       local app_name="$2"
       
       echo -e "${BLUE}🔧 Creating NewFramework application...${NC}"
       
       # Create enhanced prompt
       local gemini_prompt="Create a complete NewFramework application..."
       
       # Call API and process response
       local response_file
       response_file=$(call_gemini "$gemini_prompt")
       create_files_from_response "$response_file"
       
       # Post-processing steps
       # ...
   }
   ```

2. **Update Main Switch Statement**
   ```bash
   case $app_type in
       # ... existing cases ...
       "newframework")
           generate_newframework_app "$prompt" "$app_name"
           ;;
   esac
   ```

3. **Update Documentation**
   - Add to supported types list
   - Include examples
   - Update help text

### Extending Core Functionality

Areas for enhancement:
- Template system for custom prompts
- Plugin architecture for extensions  
- Configuration management system
- Logging and monitoring improvements
- Performance optimizations

## 🔒 Security Guidelines

### Security Considerations

- Never commit API keys or secrets
- Validate all user inputs
- Use secure temporary file handling  
- Follow principle of least privilege
- Sanitize generated code paths
- Implement rate limiting for API calls

### Secure Coding Practices

```bash
# Input validation
validate_input() {
    local input="$1"
    
    # Check for dangerous characters
    if [[ "$input" =~ [';|&$`<>'] ]]; then
        echo "Error: Invalid characters in input" >&2
        return 1
    fi
    
    # Length validation
    if [[ ${#input} -gt 1000 ]]; then
        echo "Error: Input too long" >&2
        return 1
    fi
}

# Secure temp file handling
temp_file=$(mktemp) || exit 1
trap 'rm -f "$temp_file"' EXIT
```

## 📋 Pull Request Guidelines

### PR Requirements

- [ ] Clear description of changes
- [ ] All tests pass
- [ ] Documentation updated
- [ ] Commit messages follow conventions
- [ ] No merge conflicts
- [ ] Security review completed

### PR Template

```markdown
**Description**
Brief description of changes.

**Type of Change**
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other (please describe)

**Testing**
- [ ] Manual testing completed
- [ ] All framework types tested
- [ ] Error scenarios tested

**Documentation**
- [ ] README updated
- [ ] API docs updated
- [ ] Examples added/updated

**Checklist**
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] No sensitive information included
```

### Review Process

1. **Automated Checks**: Syntax validation, basic testing
2. **Code Review**: Maintainer review of changes
3. **Testing**: Functional testing of new features
4. **Documentation Review**: Ensure docs are complete
5. **Merge**: After all checks pass

## 🏷 Release Process

### Versioning

We use [Semantic Versioning](https://semver.org/):
- `MAJOR.MINOR.PATCH`
- Major: Breaking changes
- Minor: New features (backward compatible)
- Patch: Bug fixes (backward compatible)

### Release Checklist

- [ ] All issues in milestone closed
- [ ] Documentation updated
- [ ] Testing completed
- [ ] CHANGELOG updated
- [ ] Version number bumped
- [ ] Release notes prepared

## 🎯 Project Goals

### Current Priorities

1. **Stability**: Robust error handling and reliability
2. **Documentation**: Comprehensive guides and examples
3. **Framework Support**: More framework generators
4. **User Experience**: Improved CLI interface
5. **Performance**: Faster generation and better resource usage

### Long-term Vision

- Web-based interface for easier interaction
- Advanced templating system
- Plugin ecosystem for community extensions
- Integration with popular development tools
- Support for more complex application architectures

## 📞 Getting Help

### Community Support

- **GitHub Discussions**: Ask questions and share ideas
- **Issues**: Report bugs and request features
- **Documentation**: Check docs/ folder for guides

### Maintainer Contact

For urgent security issues or major contributions:
- Create a private issue
- Email maintainers (see GitHub profiles)
- Include detailed information and context

## 🙏 Recognition

We appreciate all contributions! Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Acknowledged in documentation
- Invited to join the maintainer team (for significant contributions)

### Hall of Fame

- Initial contributors and bug reporters
- Documentation writers and reviewers
- Feature implementers and testers
- Community supporters and helpers

Thank you for helping make the Gemini App Generator better for everyone! 🚀