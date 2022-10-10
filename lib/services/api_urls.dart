class ApiUrls{

    static const String baseUrl = "http://ox21nft.xyz/api/";
    static const String bitcoinConversionKey = '511a9e6ffef230c10afb57f286dae642831f3fcd';
    // static const String bitcoinConversionUrl = 'https://api.nomics.com/v1/currencies/ticker?key=a854281e5a8e2a592ec80e3ce03c2fc1688f4f33&ids=BTC&interval=1d,30d&per-page=100&page=1';
    static const String bitcoinConversionUrl = baseUrl + 'live_btc_api';

  // a854281e5a8e2a592ec80e3ce03c2fc1688f4f33

  static const String signUpUrl =baseUrl+  'signup';
    static const String termsAndConditionsLink = baseUrl + 'get_terms';
    static const String privacyPolicy = baseUrl + 'get_privacy_policy';
    static const String copyrightsUrl = baseUrl + 'get_copyright_policy';

  static const String loginUrl =baseUrl+  'signin';
  static const String forgotPassword =baseUrl+  'forget_password';
  static const String changePassword = baseUrl+  'change_password';

  static const String getChannels =baseUrl+  'get_channels';
  static const String getMySubscribedChannels =baseUrl+  'my_channels?user_id=';
  static const String getLanguages =baseUrl+  'get_languages';
  static const String getPriceList = baseUrl + 'getTopBannerPrices';
  static const String getUserData =baseUrl+  'get_user_by_id/';
  static const String updateAddress = baseUrl + 'update_address';
  static const String updateUserLanguage = baseUrl + 'update_user_language';
  static const String addChannels = baseUrl + 'add_channels';
  static const String addUserVideos = baseUrl + 'addUserVideos';


  static const String getVideos = baseUrl + 'getMyPost/';

  static const String getAllPost = baseUrl + 'getAllPost?';   /// get -> user_id=400&last_id=100&channel_id=111
  static const String getUserPlaylist = baseUrl + 'getUserPlaylist/';
  static const String addPlaylist = baseUrl + 'add_playlist';
  static const String getShorts = baseUrl + 'add_channels';
  static const String checkLastPostStatus = baseUrl + 'checkLastPostStatus/';

  static const String likePost = baseUrl + 'likePost?';  //likePost?user_id=4&post_id=70
  static const String dislikePost = baseUrl + 'dislikePost?'; //dislikePost?user_id=4&post_id=70
  static const String removelikeDislikePost = baseUrl + 'removeLikeOrDislike?';   //removeLikeOrDislike?user_id=6&post_id=17



  static const String checkPreviousPendingTopBannerPurchase =baseUrl+  'check_my_banner_status?user_id=';
  static const String buyBanner =baseUrl+  'buy_banner';
  static const String getBiddersList =baseUrl+  'get_bidders?hash='; //?hash=3982377d-193f-5b3c-b249-bbf09072c042
  static const String checkbannerStatus =baseUrl+  'check_banner_status?hash='; //?hash=3982377d-193f-5b3c-b249-bbf09072c042
  static const String checkDomain =baseUrl+  'domain_check?'; //domain=AnilV&user_id=4
  static const String buyDomain =baseUrl+  'buy_domain';
  static const String getMyDomains = baseUrl + 'my_domains?'; //user_id=179
  static const String create_channels = baseUrl + 'create_channels';
  static const String myChannels = baseUrl + 'add_channels';
  static const String my_banners = baseUrl + 'my_banners?'; //user_id=179
  static const String update_banner_image = baseUrl + 'update_banner_image';
  static const String depositBTC = baseUrl + 'deposit_btc';
    static const String checkPendingDepositOrders = baseUrl + 'my_deposit_btc?status=0&user_id=';
    static const String conver_btc = baseUrl + 'conver_btc';
    static const String addResalePrice = baseUrl + 'set_banner_for_sell';
    static const String addFreshnessPoints = baseUrl + 'addFreshnessPoints';

    static const String payment_for_banner = baseUrl + 'payment_for_banner';
    static const String payment_for_domain = baseUrl + 'payment_for_domain_by_oderID';

    static const String do_not_see_user_post = baseUrl + 'do_not_see_user_post'; //"block_by":6,"block_to":4
    static const String checkAmountForOrderId = baseUrl + 'check_order_id';
    static const String checkAmountForOrderIdInDomain = baseUrl + 'check_domain_order_id';
    static const String report_post = baseUrl + 'report_post';
    static const String Community_court_post = baseUrl + 'Community_court_post?';
    static const String voteForPost = baseUrl + 'vote_for_post_report';
    static const String get_vmails = baseUrl + 'get_vmails'; //?user_id=6&type=sent  // received , all
    static const String get_vmails_detail = baseUrl + 'get_vmails_detail'; //user_id=4&id=5
    static const String get_owner_by_domain = baseUrl + 'get_owner_by_domain';
    static const String send_mail = baseUrl + 'send_mail';
    static const String delete_vmail = baseUrl + 'delete_vmail';
    static const String block_domain = baseUrl + 'block_domain';
    static const String banner_for_rents = baseUrl + 'banner_for_rents';
    static const String set_banner_for_rent = baseUrl + 'set_banner_for_rent';
    static const String buy_banner_on_rent = baseUrl + 'buy_banner_on_rent';
    static const String my_buyed_rented_banner = baseUrl + 'my_buyed_rented_banner';
    static const String payment_for_rented_domains = baseUrl + 'payment_for_rented_domains';
    static const String add_points_by_in_app_purchase = baseUrl + 'add_points_by_in_app_purchase';
    static const String confirmDomainPurchaseForBannerRent = baseUrl + 'confirmDomainPurchaseForBannerRent';
    static const String createGroup = baseUrl + 'create_group';
    static const String myGroups = baseUrl + 'my_groups'; //?user_id=4&type=all
    static const String checkgroup = baseUrl + 'check_group'; //?user_id=5&id=1&groupID=122312427e451d57-819a-551b-b0fe-41ec8ce12403
    static const String join_group = baseUrl + 'join_group'; //?user_id=6&groupID=122312427e451d57-819a-551b-b0fe-41ec8ce12403&nickname=Anil
    static const String send_message_in_group = baseUrl + 'send_message_in_group'; //?user_id=6&groupID=122312427e451d57-819a-551b-b0fe-41ec8ce12403&nickname=Anil
    static const String getGroupDetail = baseUrl + 'group_detail'; //?id=4&is_chat=1&is_member=1&is_detail=1&user_id=6
    static const String acceptRejectGroupMemberRequest = baseUrl + 'responce_group_join_request'; //?group_id=4&user_id=4&status=1&member_id=7
    static const String removeMemberFromGroup = baseUrl + 'remove_member_from_group'; //?group_id=4&user_id=4&status=1&member_id=7
    static const String edit_group_member_nickname = baseUrl + 'edit_group_member_nickname'; //?group_id=4&user_id=4&status=1&member_id=7
    static const String leave_group = baseUrl + 'leave_group'; //?group_id=5&user_id=4
    static const String delete_account = baseUrl + 'delete_account'; //?group_id=5&user_id=4
    static const String getPostComments = baseUrl + 'get_post_comment_list'; //?user_id=1&post_id=22
    static const String comment_on_post = baseUrl + 'comment_on_post';
    static const String uploadWebToken = baseUrl + 'upload-web-token';
    // static const String checkgroup = baseUrl + 'check_group'; //?user_id=4&type=all






//



}



// the url issss http://ox21nft.xyz/api/join_group?user_id=363&groupID=9eda274d-74b8-52e7-b49d-30a1144098e1b7828cc8-1a00-5979-9675-c9437b1bbcfe&nickname=Robert

// the requesst for http://ox21nft.xyz/api/buy_banner is {user_id: 281, uuid: 3982377d-193f-5b3c-b249-bbf09072c042, price: 20, hash: xPSvuoaQGacebmwEj0smUat2zecNHhYTIE5MhX0TBt2, language: 2, channel: 167, page_number: 9, country: , state: , city: }



// the response for http://ox21nft.xyz/api/buy_banner is {status: 1, message: Banner has been purchased successfully, data: {hash: xPSvuoaQGacebmwEj0smUat2zecNHhYTIE5MhX0TBt2, uuid: 3982377d-193f-5b3c-b249-bbf09072c042, user_id: 281, price: 20, orderID: 393973, channel: 167, page_number: 9, language: 2, payment_status: 1, status: 1, expire_time: 1655293567}, remaining_btc: 0}