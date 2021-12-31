[Sourcery](https://github.com/krzysztofzablocki/Sourcery) is a code generator for Swift language, built on top of Apple's own SwiftSyntax. It extends the language abstractions to allow you to generate boilerplate code automatically.

**Sourcery allows you automate writing of repetitive boilerplace code!**

> To read more about Sourcery you can go to their [website](https://github.com/krzysztofzablocki/Sourcery), this document is about how to use it inside the ABN project.

> This README is a quick guide. [More elaborate documentation and common scenario's can be found here](https://confluence.aws.abnamro.org/pages/viewpage.action?spaceKey=MOB&title=Sourcery)

# Installation
Sourcery is added as a Pod to lock the version that is used across teams.

**Important** The `bin` directory is excluded in Git, therefor the installation is not complete. 
To use Sourcery, remove the `Sourcery` folder in the `Pods` directory and run `pod update Sourcery`

# Setup
Sourcery is configured in the `.sourcery.yml` file located in the `Sourcery` folder. To enable Sourcery to scan the sources, the path needs to be configured in the `sources` list in the configuration.

# Usage
## Create a mock generated from a protocol

1. Create a new file for the mock and give it the appropriate name, e.g. `Mock<your_protocol>.swift`
2. Add the folowing code to make your protocol auto mockable:
   ```swift
        // sourcery: AutoMockable
        extension <protocol_type_name> { }
        
        // sourcery:inline:auto:<protocol_type_name>.AutoMockable
        
        // sourcery:end
   ```
3. Run `./sourcery.sh` from the Terminal, run the command from the base folder of the project.
4. The generated code will be placed inside the `sourcery:inline` / `sourcery:end` block.

## Extra options
A number of options are provided to control the output of the generated mock.
Add the options next to the sourcery tag e.g.:
```swift
    // sourcery: AutoMockable, baseClass=Service
    extension <protocol_type_name> { }
```

* `accessLevel=public|internal`: By default the generated mock has the same access level as the protocol it is generated from. This option is used to override Access Control Level for the generated mock.
* `baseClass`: Sets a different base class for the mock.
* `mockName`: Override the default name  `Mock<your_protocol>` with your own name.
* `overrides=['myFunction(_:)', 'init']`: Indicate methods that require the 'override' keyword. Only used when the mock has a base class.


