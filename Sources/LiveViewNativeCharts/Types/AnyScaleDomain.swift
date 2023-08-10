//
//  AnyScaleDomain.swift
//
//
//  Created by Carson.Katri on 6/20/23.
//

import Charts
import Foundation

/// The domain used with ``ChartXScaleModifier`` and ``ChartYScaleModifier`` modifiers.
///
/// There are several different types of domain.
///
/// ### Automatic Domain
/// This is the default domain, inferred from the values in the chart.
/// * `includes_zero` - includes `0` when displaying numeric values.
/// * `reversed` - flips the range of values to be descending.
/// ```elixir
/// :automatic
/// {:automatic, [includes_zero: true, reversed: true]}
/// ```
///
/// ### Value Range
/// Numbers and date ranges can be used with a tuple.
/// The first element is the lower bound, and the second element is the upper bound.
///
/// ```elixir
/// {1, 5} # range from 1 to 5.
/// {DateTime.utc_now(), DateTime.add(DateTime.utc_now(), 1, :day)} # today to tomorrow
/// ```
///
/// ### Categories
/// Pass an array of strings to create a categorical domain.
///
/// ```elixir
/// ["Category 1", "Category 2", "Category 3"]
/// ```
///
/// Each category will be displayed on the axis.
#if swift(>=5.8)
@_documentation(visibility: public)
#endif
enum AnyScaleDomain: Decodable, ScaleDomain {
    func _makeScaleDomain() -> _ScaleDomainOutputs {
        switch self {
        case .automatic(let automatic):
            return automatic._makeScaleDomain()
        case .numericRange(let numericRange):
            return numericRange._makeScaleDomain()
        case .dateRange(let dateRange):
            return dateRange._makeScaleDomain()
        case .values(let values):
            return values._makeScaleDomain()
        }
    }
    
    case automatic(AutomaticScaleDomain)
    case numericRange(ClosedRange<Double>)
    case dateRange(ClosedRange<Date>)
    case values([String])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch try container.decode(ScaleDomainType.self, forKey: .type) {
        case .automatic:
            self = .automatic(
                .automatic(
                    includesZero: try container.decodeIfPresent(Bool.self, forKey: .includesZero),
                    reversed: try container.decodeIfPresent(Bool.self, forKey: .reversed)
                )
            )
        case .numericRange:
            self = .numericRange(
                (try container.decode(Double.self, forKey: .lowerBound))
                ...
                (try container.decode(Double.self, forKey: .upperBound))
            )
        case .dateRange:
            self = .dateRange(
                (try container.decode(Date.self, forKey: .lowerBound))
                ...
                (try container.decode(Date.self, forKey: .upperBound))
            )
        case .values:
            self = .values(
                try container.decode([String].self, forKey: .values)
            )
        }
    }
    
    enum ScaleDomainType: String, Decodable {
        case automatic
        case numericRange = "numeric_range"
        case dateRange = "date_range"
        case values
    }
    
    enum CodingKeys: CodingKey {
        case type
        
        case includesZero
        case reversed
        
        case lowerBound
        case upperBound
        
        case values
    }
}
