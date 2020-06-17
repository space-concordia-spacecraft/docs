# Fprime as a Component Architecture

Fprime is a framework developed at the Jet Propulsion Laboratory with the goal of creating a framework capable of rapid development and deployment for spaceflight and other embedded software applications. The framework uses the concept of "ports" and "components" in order to achieve a component-driven architecture.

## Components

Components are individual encapsulations of behavior that interface with other components via strongly typed ports. They are not aware of other components and are used to execute commands and produce telemetry. Additionally, they are instantiated at run time and connected via ports into a "Topology". It's important to note that there should be no code dependencies between components, only on port interface types.

In order to create a component, use the component tag

```xml
<component name="ComponentName" kind="kind" namespace="Namespace">
</component>
```

The attributes for the `<component>` tag are the following:

|Attribute|Description|
|---|---|
|name|The component name|
|kind|What the threading/queuing model of the component is. Can be `passive`, `queued`, or `active`|
|namespace|The C++ namespace the component will be defined in|

#### Passive Components

Passive components have no thread and the port calls are made directly to user derived class methods. These types of components can have synchronous and guarded ports but no asynchronous ports since there is no queue. 

Here's an example:

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/Svc/PassiveConsoleTextLogger/PassiveTextLoggerComponentAi.xml)._

```xml
<component name="PassiveTextLogger" kind="passive" namespace="Svc">
    <import_port_type>Fw/Log/LogTextPortAi.xml</import_port_type>
    <comment>A component to implement log messages with a print to the console</comment>
    <ports>
        <!-- Input text logging port -->
        <port name="TextLogger" data_type="Fw::LogText" kind="sync_input" max_number="1">
            <comment>
            Logging port
            </comment>
        </port>
    </ports>
</component>
```

#### Queued Components

Queued components have no thread. A queue is instantiated, and asynchronous port calls are serialized and placed on queue. Implementation class makes call to base class to dispatch calls to implementation class methods for asynchronous ports. Can be made from any implementation class function. Thread of execution provided by caller to a synchronous port.

Queued component can have all three port types, but it needs at least one synchronous or guarded port to unload the queue and at least one asynchronous port for the queue to make sense. No thread, a queue is instantiated, and asynchronous port calls are serialized and placed on queue. Implementation class makes call to base class to dispatch calls to implementation class methods for asynchronous ports. (Can be made from any implementation class function, thread of execution provided by caller to a synchronous port)

Here's an example:

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
<component name="MathReceiver" kind="queued" namespace="Ref">
    <comment>Component sending a math operation</comment>
    <ports>
        <port name="mathIn" data_type="Ref::MathOp" kind="async_input">
            <comment>
            Port for receiving the math operation
            </comment>
        </port>
        <port name="mathOut" data_type="Ref::MathResult" kind="output">
            <comment>
            Port for returning the math result
            </comment>
        </port>
        <port name="SchedIn" data_type="Sched" kind="sync_input">
            <comment>
            The rate group scheduler input
            </comment>
        </port>
    </ports>
    <commands> ... </commands>
    <telemetry> ... </telemetry>
    <events> ... </events>
    <parameters> ... </parameters>
    
</component>
```

#### Active Components

Component has thread of execution as well as queue. Thread dispatches port calls from queue as it executes based on thread scheduler.

An active component can have all three varieties, but needs at least one asynchronous port for the queue and thread to make sense. Component has thread of execution as well as queue, thread dispatches port calls from queue as it executes based on thread scheduler.

Here's an example:

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
<component name="MathSender" kind="active" namespace="Ref">
    <ports>
        <port name="mathOut" data_type="Ref::MathOp" kind="output">
            <comment>
            Port for sending the math operation
            </comment>
        </port>
        <port name="mathIn" data_type="Ref::MathResult" kind="async_input">
            <comment>
            Port for returning the math result
            </comment>
        </port>
    </ports>
    <commands> ... </commands>
    <telemetry> ... </telemetry>
    <events> ... </events>
</component>
```

## Ports TODO: Add interface examples for each type of port

Ports are directional typed interfaces in the architecture. The direction is only related to the invocation, not necessarily how the data flows as ports can also retrieve data. They can connect to other typed ports, components and serialized ports. Additionally, multiple output ports can be connected to a single input port.

In order to create a port, use the interface tag

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
<interface name="MathOp" namespace="Ref">
    <comment>
    Port to perform an operation on two numbers
    </comment>
    <args>
        <arg name="val1" type="F32">
		</arg>
        <arg name="val2" type="F32">
		</arg>
        <arg name="operation" type="ENUM">
            <enum name="MathOperation">
                <item name="MATH_ADD"/>
                <item name="MATH_SUB"/>
                <item name="MATH_MULTIPLY"/>
                <item name="MATH_DIVIDE"/>
            </enum>
            <comment>operation argument</comment>
        </arg>
    </args>
</interface>
```

If you wish to use the new port in a component, you must use the `<port>`

_Note: the tag should be a child of the `<ports>` tag._

```xml
<port name="PortName" data_type="Namespace::name" kind="kind">
</port>
```

The following table contains information about the attributes for the `<port>` tag:

|Attribute|Description|
|---|---|
|name|The port name|
|data_type|The type of the port as defined in the included port definitions, in the form `namepace::name`|
|kind|The kind of port. Can be `sync_input`,`async_input`,`guarded_input`, or `output`|

### Input Ports
#### Synchronous Port

Port calls directly invoke derived functions without passing through queue.

Here's an example

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
<port name="SchedIn" data_type="Sched" kind="sync_input">
    <comment>
    The rate group scheduler input
    </comment>
</port>
```

#### Guarded Port

Port calls directly invoke derived functions, but only after locking a mutex shared by all guarded ports in component.

Here's an example

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/Svc/BufferManager/BufferManagerComponentAi.xml)._

```xml
<port name="bufferSendIn" data_type="Fw::BufferSend"  kind="guarded_input"    max_number="1">
        </port>
```

#### Asynchronous Port

Port calls are placed in a queue and dispatched on thread emptying the queue.

Here's an example

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
<port name="mathIn" data_type="Ref::MathResult" kind="async_input">
    <comment>
    Port for returning the math result
    </comment>
</port>
```

### Output Port

Output ports are invoked by calling generated base class functions from the implementation class.

Here's an example

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
<port name="mathOut" data_type="Ref::MathOp" kind="output">
    <comment>
    Port for sending the math operation
    </comment>
</port>
```

## Serialization TODO: rewrite this

Serialization is a key concept in the framework. Definition: Taking a specific set of typed values or function arguments and converting them in an architecture-independent way into a data buffer. Port calls and commands and their arguments are serialized and placed on message queue in components. Command arguments and telemetry values are passed and encoded/decoded into this form. Components that store and pass data can use this orm and not require knowledge of underlying types. User can define arbitrary interface argument types and framework automatically serializes. User can define complex types in XML and code generator will generate classes that are serializable for use internally and to and from ground software.

#### Serialization Ports

A special optional port that handles serialized buffers. Takes as input a serialized buffer when it is an input port, and outputs a serialized buffer when it is an output port. Can be connected to any typed port (almost). For input port, calling port detects connection and serializes arguments. For output port, serialized port calls interface on typed port that deserializes arguments. Not supported for ports with return types. Useful for generic storage and communication components that don't need to know type. Allows design and implementation of C&DH (command and data handling) components that can be reused.

## Commands TODO: rewrite this

|Attribute|Description|
|---|---|
|mnemonic|A text version of the command name, used in sequences and the ground tool|
|opcode|A numeric value for the command. The value is relative to a base value set when the component is added to a topology|
|kind|The kind of command. Can be `sync_input`,`async_input`,`guarded_input`, or `output`|

## Telemetry TODO: rewrite this

|Attribute|Description|
|---|---|
|name|The channel name|
|id|A numeric value for the channel. The value is relative to a base value set when the component is added to a topology|
|data_type|The data type of the channel. Can be a built-in type, an enumeration or an externally defined serializable type|

## Events TODO: rewrite this

|Attribute|Description|
|---|---|
|name|The event name|
|severity|The severity of the event. Can be DIAGNOSTIC, ACTIVITY_LO, ACTIVITY_HI, WARNING_LO, WARNING_HI or FATAL.
|id|A numeric value for the event. The value is relative to a base value set when the component is added to a topology|
|format_string|A C-style format string for displaying the event and the argument values.|

## Parameters TODO: rewrite this

Parameters are traditional means of storing non-volatile state. Framework provides code generation to manage, but user must write specific storage component. During initialization, a public method in the class is called that retrieves the parameters and stores copies locally. Can be called again if parameter is updated.

|Attribute|Description|
|---|---|
|id|The unique parameter ID. Relative to base ID set for the component in the topology|
|name|The parameter name|
|data_type|The data type of the parameter. Must be a built-in type|
|default|Default value assigned to the parameter if there is an error retrieving it.|
|set_opcode|The opcode of the command to set the parameter. Must not overlap with any of the command opcodes|
|save_opcode|The opcode of the command to save the parameter. Must not overlap with any of the command opcodes|