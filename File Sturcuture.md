# data providers will contain the code which will make direct calls to the API

# Models will contain the structures classes used to model. for example the structure of the Profile which will contain info about the user will be created here

# are the ones that provide simple interface to interact with the data providers. we don't call the data providers directly in the blocs folder, but we call their interfaces in this folder

# blocs will (obviously) contain the states and events and will be responsible to generate the appropriate state based on the event. it is the component that can manipulate the UI based on the given event

# screens will contain all the UIs required for that component
