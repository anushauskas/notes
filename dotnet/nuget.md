# Publish nuget

To build and publish nuget package go to project directory 

```sh
# List vulnerable packages
dotnet list package --vulnerable --include-transitive --source https://api.nuget.org/v3/index.json 

# List local nuget cashes
dotnet nuget locals all --list

# Clear local cache 
dotnet nuget locals all --clear

# List nuget Sources
dotnet nuget list source

// Enable nuget Source
dotnet nuget enable source LocalNugets

// Enable nuget Source
dotnet nuget disable source LocalNugets

# Restore project
dotnet restore --source https://api.nuget.org/v3/index.json 

# Create package from csproj
dotnet pack --no-restore -p:PackageVersion=1.0.1

cd bin\Release

# -s is your nuget source
dotnet nuget push Package.Name.1.0.1.nupkg -s LocalNugets

``` 