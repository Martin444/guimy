import 'package:graphql/client.dart';

final HttpLink _httpLink = HttpLink(
    uri: 'https://guimy-data.herokuapp.com/v1/graphql',
    headers: {
      "content-type":"application/json",
      "x-hasura-admin-secret":"1qaz2wsx3edc4rfv5tgb6yhn7ujm8ik,9ol.0p"
    }
);
String token = "1qaz2wsx3edc4rfv5tgb6yhn7ujm8ik,9ol.0p";

final AuthLink _authLink = AuthLink(
    getToken: () async => 'Bearer $token',
);

final Link _link = _authLink.concat(_httpLink);

final GraphQLClient _client = GraphQLClient(
        cache: InMemoryCache(),
        link: _link,
    );

// ################# query

const String readRepositories = r'''
  query MyQuery ( $token: String){
  users(where: {tokenUser: {_eq: $token}}) {
    id
    name
    password
    phone
    extend_phone
    email
    avatar
  }
}
''';

const String readRestaurant = r'''
  query MyQuery($_restaurantuid: uuid!) {
  restaurant_categories(where: {restaurant: {_eq: $_restaurantuid}}) {
    category
    restaurant
    information {
      name
      logo
      description
    }
  }
  restaurants_by_pk(id: $_restaurantuid) {
    email
    id
    latitude
    longitude
    logo
    name
    phone
    details
  }
}

''';

const String readMissions = r'''
  query MyQuery {
    missions {
      gives_points
      name
      id
      needs_action
      needs_total
    }
  }
''';


const String readComentarios = r'''
  query MyQuery($idRest: uuid) {
  restaurant_comments(where: {idRestaurant: {_eq: $idRest}}) {
    NameComplete
    commentary
    date_public
  }
}
''';


const String readMesages = r'''
  query MyQuery($idUser: uuid) {
  chats(where: {sender: {_eq: $idUser}}) {
    image
    message
    tag
    state
    created_at
    category
  }
}
''';




// ####### mutacion #######

final String _insertUser = r"""
  mutation insertUser($tokenUser : String, $country : String, $email: String, $name: name, $pass:String, $phone:String, $extendphone:String, $avatar:String) {
  insert_users_one(object:{
    tokenUser : $tokenUser
    country : $country
    email: $email
    name : $name
    password : $pass
    phone : $phone
    extend_phone : $extendphone
    avatar : $avatar
  }){
    id
    email
    name
  }
}
  """;
final String _insertReserva = r"""
  mutation MyMutation($user: uuid, $first_names: String, $last_names: String, $userDNI: String, $max_guests: smallint, $date: timestamptz, $message: String, $rest: uuid!) {
  insert_reservations_one(object: {user: $user, first_names: $first_names, last_names: $last_names, ID: $userDNI, max_guests: $max_guests, date: $date, message: $message, restaurant: $rest}) {
    first_names
    last_names
    date
    max_guests
    message
    restaurant
  }
}

  """;
final String _insertComentarioRest = r"""
  mutation MyMutation($idUser: uuid, $idRest: uuid, $coment: String, $name:String) {
  insert_restaurant_comments_one(object: {idUser: $idUser, idRestaurant: $idRest, commentary: $coment, NameComplete: $name}) {
    commentary
    date_public
    NameComplete
  }
}
  """;


final String _insertReportar = r"""
  mutation MyMutation($state: String, $category:String,$tag: String, $msg: String, $img: String, $userID: uuid) {
  insert_chats_one(object: {state: $state, category: $category, tag: $tag, message: $msg, image: $img, sender: $userID}) {
    category
    image
    message
    tag
    state
    created_at
  }
}
  """;

  







class GraphQLClass {

  ejecutarConsultaInicio(String token)async{

    final QueryOptions options = QueryOptions(
        documentNode: gql(readRepositories),
        variables: <String, dynamic>{
          "token" : token
        },
    );

    final QueryResult result = await _client.query(options);
    if (result.hasException) {
        print(result.exception.toString());
    }
    print("### ${result.data}");
    final Map repositories = result.data["users"][0];
    print("### $repositories");

    return repositories;
  }

  insertarUsuario(
    String userId,
    String userAvatar,
    String userName,
    String userPassword,
    String extencionPhone,
    String userPhone,
    String userCountry,
    String userEmail,
  )async{

    final MutationOptions options = MutationOptions(
      documentNode: gql(_insertUser),
      variables: <String, dynamic>{
        "tokenUser"     : userId,
        "country"       : userCountry,
        "email"         : userEmail,
        "name"          : userName,
        "pass"          : userPassword,
        "phone"         : userPhone,
        "extendphone"   : extencionPhone,
        "avatar"        : userAvatar
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
        print(result.exception.toString());
        
        return;
    }
    print(result.data);

    // final bool isStarred =
    //     result.data['action']['starrable']['viewerHasStarred'] as bool;

    // if (isStarred) {
    //   print('Thanks for your star!');
    //   return;
    // }


  }

  consultarRestaurante(String idRest)async{
    final QueryOptions options = QueryOptions(
        documentNode: gql(readRestaurant),
        variables: <String, dynamic>{
          "_restaurantuid" : idRest
        },
    );

    final QueryResult result = await _client.query(options);
    if (result.hasException) {
        print(result.exception.toString());
    }
    // print("### resultado restaurante: ${result.data}");
    // final List restaurant_categories = result.data["restaurant_categories"];
    // print("### mapa restaurante: $restaurant_categories");
    // final Map restaurants_by_pk = result.data["restaurants_by_pk"];
    // print("### mapa restaurante: $restaurants_by_pk");
    Map resultado = result.data;
    return resultado;
  }

  Future<Map> ejecutarConsultaMisiones()async{

    final QueryOptions options = QueryOptions(
        documentNode: gql(readMissions),
        // variables: <String, dynamic>{
        //   // "token" : token
        // },
    );

    final QueryResult result = await _client.query(options);
    if (result.hasException) {
        print(result.exception.toString());
    }
    print("### ${result.data}");
    final Map misiones = await result.data;
    print("### $misiones");

    return misiones;
  }


  insertarComentarioRest(
    String idUser,
    String idRest,
    String coment,
    String name,
  )async{

    final MutationOptions options = MutationOptions(
      documentNode: gql(_insertComentarioRest),
      variables: <String, dynamic>{
        "idUser": idUser,
        "idRest": idRest,
        "coment": coment,
        "name"  : name
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
        print(result.exception.toString());
        
        return;
    }
    print(result.data);

    // final bool isStarred =
    //     result.data['action']['starrable']['viewerHasStarred'] as bool;

    // if (isStarred) {
    //   print('Thanks for your star!');
    //   return;
    // }
    return result.data;

  }



  insertarReserva(
    String userID,
    String reservafirstName,
    String reservalastName,
    String reservanumeroIdentidad,
    int    reservamaxPersons,
    String reservadate,
    String reservamessage,
    String restaurantID
  )async{

    final MutationOptions options = MutationOptions(
      documentNode: gql(_insertReserva),
      variables: <String, dynamic>{
        "user"        : userID,
        "first_names" : reservafirstName,
        "last_names"  : reservalastName,
        "userDNI"     : reservanumeroIdentidad,
        "max_guests"  : reservamaxPersons,
        "date"        : reservadate,
        "message"     : reservamessage,
        "rest"        : restaurantID
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
        print(result.exception.toString());
        
        return;
    }
    print(result.data);

    // final bool isStarred =
    //     result.data['action']['starrable']['viewerHasStarred'] as bool;

    // if (isStarred) {
    //   print('Thanks for your star!');
    //   return;
    // }


  }

  ejecutarConsultaComentarios(String idRest)async{

    final QueryOptions options = QueryOptions(
        documentNode: gql(readComentarios),
        variables: <String, dynamic>{
          "idRest": idRest
        },
    );

    final QueryResult result = await _client.query(options);
    if (result.hasException) {
        print(result.exception.toString());
    }
    print("### ${result.data}");
    final Map repositories = await result.data;
    print("### $repositories");

    return repositories;
  }


  insertarReportar(
    {
      String estado,
      String categoria,
      String tag,
      String msg,
      String imgUrl,
      String userID
    }
  )async{

    final MutationOptions options = MutationOptions(
      documentNode: gql(_insertReportar),
      variables: <String, dynamic>{
        "state"     : estado,
        "category"  : categoria,
        "tag"       : tag,
        "msg"       : msg,
        "img"       : imgUrl,
        "userID"    : userID
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
        print(result.exception.toString());
        
        return;
    }
    print(result.data);

    // final bool isStarred =
    //     result.data['action']['starrable']['viewerHasStarred'] as bool;

    // if (isStarred) {
    //   print('Thanks for your star!');
    //   return;
    // }
    return result.data;

  }



  ejecutarConsultaMensajes(String idUsuario)async{

    final QueryOptions options = QueryOptions(
        documentNode: gql(readMesages),
        variables: <String, dynamic>{
          "idUser": idUsuario
        },
    );

    final QueryResult result = await _client.query(options);
    if (result.hasException) {
        print(result.exception.toString());
    }
    print("### ${result.data}");
    final repositories = await result.data["chats"];
    print("### $repositories");

    return repositories;
  }





}