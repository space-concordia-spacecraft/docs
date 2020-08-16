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

## Ports

Ports are directional typed interfaces in the architecture. The direction is only related to the invocation, not necessarily how the data flows as ports can also retrieve data. They can connect to other typed ports, components and serialized ports. Additionally, multiple output ports can be connected to a single input port.

In order to create a new port, the user must first create an xml file with the following naming convention.

`PortNameAi.xml`

Then, they must define the port by using the `<interface>` tag, and then write all of the code that pertains to that port within the scope of the tag. For example:

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

If you wish to use the new port inside a component, you must first import it by using the `<import_port_type>`.

```xml
<import_port_type>Ref/MathPorts/MathOpPortAi.xml</import_port_type>
```

The path in the port import statement is relative to the root of the repository. Once the port has been imported declare it by using the `<port>` tag with it's attributes.

_Note: The tag should be a child of the `<ports>` tag._

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

Here's an example of code taken from within the fprime project for a synchronous port:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?oxygen RNGSchema="file:../xml/ISF_Type_Schema.rnc" type="compact"?>
<interface name="Sched" namespace="Svc">
    <comment>
    Scheduler Port with order argument
    </comment>
    <args>
        <arg name="context" type="NATIVE_UINT_TYPE">
            <comment>The call order</comment>
        </arg>
    </args>
</interface>
```

In order to use the port within a given component, the user must first import it and then declare it.

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
...
<import_port_type>Svc/Sched/SchedPortAi.xml</import_port_type>
...
<port name="SchedIn" data_type="Sched" kind="sync_input">
    <comment>
    The rate group scheduler input
    </comment>
</port>
...
```

#### Guarded Port

Port calls directly invoke derived functions, but only after locking a mutex shared by all guarded ports in component.

Here's an example of code taken from within the fprime project for a guarded port:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?oxygen RNGSchema="file:../xml/ISF_Type_Schema.rnc" type="compact"?>

<interface name="BufferSend" namespace="Fw">
    <import_serializable_type>Fw/Buffer/BufferSerializableAi.xml</import_serializable_type>
    <args>
        <arg name="fwBuffer" type="Fw::Buffer" pass_by="reference">
        </arg>
    </args>
</interface>
```

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/Svc/BufferManager/BufferManagerComponentAi.xml)._

```xml
...
<import_port_type>Fw/Buffer/BufferSendPortAi.xml</import_port_type>
...
<port name="bufferSendIn" data_type="Fw::BufferSend"  kind="guarded_input"    max_number="1">
</port>
...
```

#### Asynchronous Port

Port calls are placed in a queue and dispatched on thread emptying the queue.

Here's an example of code taken from within the fprime project for a asynchronous port:

```xml
<interface name="MathResult" namespace="Ref">
    <comment>
    Port to return the result of a math operation
    </comment>
    <args>
        <arg name="result" type="F32">
            <comment>the result of the operation</comment>
        </arg>
    </args>
</interface>
```

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
...
<import_port_type>Ref/MathPorts/MathResultPortAi.xml</import_port_type>
...
<port name="mathIn" data_type="Ref::MathResult" kind="async_input">
    <comment>
    Port for returning the math result
    </comment>
</port>
...
```

### Output Port

Output ports are invoked by calling generated base class functions from the implementation class.

Here's an example of code taken from within the fprime project for an output port:

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

_Note: The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._

```xml
...
<import_port_type>Ref/MathPorts/MathOpPortAi.xml</import_port_type>
...
<port name="mathOut" data_type="Ref::MathOp" kind="output">
    <comment>
    Port for sending the math operation
    </comment>
</port>
...
```

## Serialization

Serialization is the process of converting typed values or function arguments into a data buffer. Port calls, commands and their arguments are examples of items that are serialized and placed into queues in components. The Fprime framework will automatically serialize arbitrary interface argument types that the user defineds. Additionally, the user can define complex types in XML and the code generator that comes within Fprime will generate classes that are serializable for use internally and to and from ground software.

In order to create a serializable structure, the user must create an xml file with the following naming convention.

`NameSerializableAi.xml`

And then use the `<serializable>` tag to encapsulate the code.

```xml
<serializable namespace="Ref" name="MathOp">
    <comment>
    This value holds the values of a math operation
    </comment>
    <members>
        <member name="val1" type="F32"/>
        <member name="val2" type="F32"/>
        <member name="op" type="ENUM">
            <enum name="Operation">
                <item name="ADD"/>
                <item name="SUB"/>
                <item name="MULT"/>           
                <item name="DIVIDE"/>           
            </enum>
        </member>
        <member name="result" type="F32"/>
    </members>
</serializable>
```

#### Serialization Ports

Serialization Ports are special ports that handle serialized buffers. These ports are useful when working with generic storage and communication components that don't need to know type, allowing the design and implementation of reusable C&DH components. While input ports take in a serialized buffer, output ports return a serialized buffer. This feature is not available for ports with return types.

## Commands

A command is an instruction given to the system so that it can perform a specific action. In order to declare a command the user must use the `<command>` tag.

_Note: The tag should be a child of the `<commands>` tag. The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._
```xml
...
<command kind="async" opcode="0" mnemonic="MS_DO_MATH">
    <comment>
    Do a math operation
    </comment>
    <args>
        <arg name="val1" type="F32">
            <comment>The first value</comment>
        </arg>          
        <arg name="val2" type="F32">
            <comment>The second value</comment>
        </arg>          
        <arg name="operation" type="ENUM">
            <enum name="MathOp">
                <item name="ADD"/>
                <item name="SUBTRACT"/>
                <item name="MULTIPLY"/>           
                <item name="DIVIDE"/>           
            </enum>
            <comment>The operation to perform</comment>
        </arg>
     </args>
</command>
...
```

The following table contains the attributes used for the `<command>` tag and a description of each attribute.

|Attribute|Description|
|---|---|
|mnemonic|A text version of the command name, used in sequences and the ground tool|
|opcode|A numeric value for the command. The value is relative to a base value set when the component is added to a topology|
|kind|The kind of command. Can be `sync_input`,`async_input`,`guarded_input`, or `output`|

## Channel (Telemetry item)

Channels are defined per-component single values read and downlinked. They are also called telemetry items. In order to declare a channel the user must use the `<channel>` tag.

_Note: The tag should be a child of the `<telemetry>` tag. The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._
```xml
...
<channel id="0" name="MS_VAL1" data_type="F32">
    <comment>
    The first value
    </comment>
</channel>
...
```

The following table contains the attributes used for the `<channel>` tag and a description of each attribute.

|Attribute|Description|
|---|---|
|name|The channel name|
|id|A numeric value for the channel. The value is relative to a base value set when the component is added to a topology|
|data_type|The data type of the channel. Can be a built-in type, an enumeration or an externally defined serializable type|

## Events

An event is a type of downlinked data representing a single event within the system. In order to declare an event the user must use the `<event>` tag.

_Note: The tag should be a child of the `<events>` tag. The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._
```xml
...
<event id="0" name="MS_COMMAND_RECV" severity="ACTIVITY_LO" format_string="Math Cmd Recvd: %f %f %d"  >
    <comment>
    Math command received
    </comment>
    <args>
        <arg name="val1" type="F32">
            <comment>The val1 argument</comment>
        </arg>          
        <arg name="val2" type="F32">
            <comment>The val2 argument</comment>
        </arg>          
        <arg name="op" type="ENUM">
            <comment>The requested operation</comment>
        <enum name="MathOpEv">
            <item name="ADD_EV"/>
            <item name="SUB_EV"/>
            <item name="MULT_EV"/>           
            <item name="DIV_EV"/>           
        </enum>
        </arg>          
    </args>
</event>
...
```

The following table contains the attributes used for the `<event>` tag and a description of each attribute.

|Attribute|Description|
|---|---|
|name|The event name|
|severity|The severity of the event. Can be DIAGNOSTIC, ACTIVITY_LO, ACTIVITY_HI, WARNING_LO, WARNING_HI or FATAL.
|id|A numeric value for the event. The value is relative to a base value set when the component is added to a topology|
|format_string|A C-style format string for displaying the event and the argument values.|

## Parameters

Parameters are used to store non-volatile states. While the framework provides code generation to manage parameters, the user must write specific storage components. When initializing, a public method in the class retrieves the parameters and stores local copies. If parameters are updated, the method can be called again. In order to declare a parameter the user must use the `<parameter>` tag.

_Note: The tag should be a child of the `<parameters>` tag. The following code is incomplete and is only supposed to serve as a basic template example. If you wish to see the full code [click here](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)._
```xml
...
<parameter id="0" name="factor2" data_type="F32" default="1.0" set_opcode="10" save_opcode="11">
    <comment>
    A test parameter
    </comment>
</parameter>
...
```

The following table contains the attributes used for the `<parameter>` tag and a description of each attribute.

|Attribute|Description|
|---|---|
|id|The unique parameter ID. Relative to base ID set for the component in the topology|
|name|The parameter name|
|data_type|The data type of the parameter. Must be a built-in type|
|default|Default value assigned to the parameter if there is an error retrieving it.|
|set_opcode|The opcode of the command to set the parameter. Must not overlap with any of the command opcodes|
|save_opcode|The opcode of the command to save the parameter. Must not overlap with any of the command opcodes|