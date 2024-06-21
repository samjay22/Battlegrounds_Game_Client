--!strict 
--!optimize 2 



export type ServiceContainer = {
    Inject : (serviceName : string, service : any) -> any,
}


return 0