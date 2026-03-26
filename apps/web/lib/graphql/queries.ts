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
      flaecheHa
      maxTiefeM
      parkplatz
      beschreibung
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
      lure {
        lures
        tactics
      }
    }
  }
`;

export const WEATHER_QUERY = gql`
  query Weather($lat: Float!, $lon: Float!) {
    weather(lat: $lat, lon: $lon) {
      tempCelsius
      windSpeedKmh
      windDirection
      pressureHpa
      cloudCover
      humidity
      precipitationMm
      description
      icon
    }
  }
`;

export const LUNAR_QUERY = gql`
  query Lunar($date: String, $lat: Float, $lon: Float) {
    lunar(date: $date, lat: $lat, lon: $lon) {
      date
      moonPhasePct
      moonPhaseName
      moonIllumination
      solunarMajor1
      solunarMajor2
      solunarMinor1
      solunarMinor2
      solunarRating
    }
  }
`;

export const DASHBOARD_QUERY = gql`
  query Dashboard {
    dashboard {
      totalSessions
      successCount
      failCount
      hitRate
      recentFeedback {
        id
        spotId
        success
        note
        createdAt
      }
    }
  }
`;

export const SUBMIT_FEEDBACK = gql`
  mutation SubmitFeedback($input: FeedbackInput!) {
    submitFeedback(input: $input)
  }
`;
