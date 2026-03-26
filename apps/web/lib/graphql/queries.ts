import { gql } from "@apollo/client";

export const HEALTH_QUERY = gql`
  query Health {
    health {
      status
    }
  }
`;

export const SPOTS_QUERY = gql`
  query Spots($bundesland: String, $fishSpecies: String) {
    spots(bundesland: $bundesland, fishSpecies: $fishSpecies) {
      id
      name
      latitude
      longitude
      bundesland
      gewaesserTyp
      fishSpecies
      avgCrowdLevel
    }
  }
`;

export const RECOMMENDATIONS_QUERY = gql`
  query Recommendations($input: RecommendationInput!) {
    recommendations(input: $input) {
      spot {
        id
        name
        latitude
        longitude
        bundesland
        gewaesserTyp
        fishSpecies
        avgCrowdLevel
      }
      score
      reason
      bestWindow
      breakdown {
        bite
        quality
        convenience
        crowd
        personal
        total
        reasons
      }
    }
  }
`;

export const SPOT_QUERY = gql`
  query Spot($id: ID!) {
    spot(id: $id) {
      id
      name
      latitude
      longitude
      bundesland
      gewaesserTyp
      fishSpecies
      avgCrowdLevel
    }
  }
`;

export const SUBMIT_FEEDBACK = gql`
  mutation SubmitFeedback($input: FeedbackInput!) {
    submitFeedback(input: $input)
  }
`;
