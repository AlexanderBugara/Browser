#  README


1. To use application -> SceneDelegate -> let token = "" nedd to be changed to github token

2. Regarding: It should be possible to search/filter organizations by name

3. There applied filtering since API for searching organization by name could not be founded.

4. Pagination and customisation by page count was omitted

5. Unit tsts was omitted


Architecture and Project structure 

1. API is domain structured 
2. each API domain contains helper services 
3. each domain depends on user session which contains user token in futer could be extended
4. all functionality separated between client and server main actors
5. client can store state server has to avoid storing state
6. between client and server exists proxy for tracking server API calls and notify sender about network status
7. There is Network, Decoder, Persistent services
