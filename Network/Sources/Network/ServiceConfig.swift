//  Created by Rafal Zowal 

import Foundation

/// Sets up the configuration environment for APIServce
///
/// THE RESON WHY IT'S PUBLIC IS BECAUSE WE WANT TO HAVE POSIBILITY TO EASY SWITCH
/// ENVIROMNET TO: `test1` `test2` if we have any of them.
///
/// If this endpoint is not defined, the default configuration will be set it up for production environment.
/// The Environment Configuration can be changed at any moment by calling this endpoint.
/// - Parameter configuration: Environments are listed on EnvironmentConfiguration for production,
///     tests environments or a custom.
/// EnvironmentConfiguration includes baseURL, Web Address, Key and Secret.
class ServiceConfig {
    static let shared = ServiceConfig()

    private(set) var currentConfiguration: APIConfiguration =
        EnvironmentConfiguration.production.getConfiguration()
    private(set) var useCache: Bool = false

    func setup(apiConfiguration: EnvironmentConfiguration,
               useCache: Bool = false) {
        self.currentConfiguration = apiConfiguration.getConfiguration()
        self.useCache = useCache
    }
}
