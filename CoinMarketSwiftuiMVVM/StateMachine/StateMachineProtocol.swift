public protocol StateMachineProtocol {
  associatedtype State: Equatable
  associatedtype Event

  var state: State { get }
  var stateError: Error? { get set }

  func handleStateUpdate(_ oldState: State, new newState: State)
  func handleEvent(_ event: Event) -> State?
  func send(event: Event)
  func leaveState(_ state: State)
  func enterState(_ state: State)
}