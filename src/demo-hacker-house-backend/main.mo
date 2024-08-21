import Text "mo:base/Text";
import Hash "mo:base/Hash";
import Map "mo:base/HashMap";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor {
  type AppIdea = {
    id: Nat;
    title : Text;
    description : Text;
    useThis : Nat;
    payThis : Nat;
  };

  func natHash(n : Nat) : Hash.Hash {
    Text.hash(Nat.toText(n));
  };

  var ideas = Map.HashMap<Nat, AppIdea>(0, Nat.equal, natHash);
  var nextId : Nat = 0;

  public query func getIdeas() : async [AppIdea] {
    Iter.toArray(ideas.vals());
  };

  public func upvoteUseThis(id : Nat) : async () {
    ignore do ? {
      let idea = ideas.get(id);

      // Check if the idea exists to avoid potential null issues
      switch (idea) {
        case (?existingIdea) {
          let title = existingIdea.title;
          let description = existingIdea.description;
          let useThis = existingIdea.useThis;
          let payThis = existingIdea.payThis;

          // Safely calculate newUseThis
          let newUseThis : Nat = useThis + 1;

          // Update the idea with the new useThis value
          ideas.put(id, {id= id; title; description; useThis = newUseThis; payThis });
        };
        case null {
          // Handle the case where the idea does not exist
          // You might want to log an error or throw an exception
        };
      };
    };
  };

  public func upvotePayThis(id : Nat) : async () {
    ignore do ? {
      let idea = ideas.get(id);

      // Check if the idea exists to avoid potential null issues
      switch (idea) {
        case (?existingIdea) {
          let title = existingIdea.title;
          let description = existingIdea.description;
          let useThis = existingIdea.useThis;
          let payThis = existingIdea.payThis;

          // Safely calculate newUseThis
          let newPayThis : Nat = payThis + 1;

          // Update the idea with the new useThis value
          ideas.put(id, {id=id; title; description; useThis; payThis= newPayThis });
        };
        case null {
          // Handle the case where the idea does not exist
          // You might want to log an error or throw an exception
        };
      };
    };
  };

  public query func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  public func addAppIdea(title: Text, description : Text) : async [AppIdea] {
    let id = nextId;
    ideas.put(id, {id=id; title = title; description = description; payThis = 0; useThis = 0 });
    nextId += 1;
    Iter.toArray(ideas.vals());
  };

  // Create a function that transform's the raw content into an HTTP payload.

};
