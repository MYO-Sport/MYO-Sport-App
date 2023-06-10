class ApiClient {

  //Live Server
  static final String baseUrl = 'http://3.19.56.228:3001/';
  static final String mediaImgUrl = 'http://3.19.56.228:3001/uploads/images/';

  //CherryByte Local Server
  // static final String baseUrl = 'http://192.168.100.11:3002/';
  // static final String mediaImgUrl = 'http://192.168.100.11:3002/uploads/images/';

  //Brilliant Games IP
  // static final String baseUrl = 'http://192.168.2.124:3001/';
  // static final String mediaImgUrl = 'http://192.168.2.124:3001/uploads/images/';

  // static final String baseUrl = 'http://192.168.100.30:3001/';
  // static final String mediaImgUrl = 'http://192.168.100.30:3001/uploads/images/';

  static final String webUrlConcept2 = 'https://log.concept2.com/oauth/authorize?client_id=lml0j3pwEih2egPLFoBNuOcoJkY4yFR3CB5Olrrd%20&scope=user:read,results:read&response_type=code&redirect_uri=http://api.myosport.co/authenticated';
  // static final String webUrlStrava = 'https://www.strava.com/oauth/authorize?client_id=74665&redirect_uri=http%3A%2F%2F3.19.56.228:3001%2Fapi%2Fworkout%2Fv1%2Fauthenticate%2Fstrava%2F${widget.userId}&response_type=code&scope=read&scope=read_all&scope=profile%3Aread_all&scope=activity%3Awrite&scope=activity%3Aread_all';


  static final String urlSignUp = baseUrl + 'api/user/add';
  static final String urlLogin = baseUrl + 'api/user/login';
  static final String urlForgotPassword = baseUrl + 'api/user/v1/forgot/password';
  static final String urlGetClubs = baseUrl + 'api/user/v1/assigned/clubs/';
  static final String urlGetAssignedClub = baseUrl + 'api/user/v2/assigned/clubs/';
  static final String urlGetAllClubs = baseUrl + 'api/user/v2/all-clubs/';
  static final String urlAssignClub = baseUrl + 'api/user/v1/assign/club/';
  static final String urlGetTeams = baseUrl + 'api/user/v1/assigned/teams/';
  static final String urlAssignTeams = baseUrl + 'api/user/v1/assign/team/';
  static final String urlGetCoaches = baseUrl + 'api/user/v1/assigned/coaches/';
  static final String urlAssignCoach = baseUrl + 'api/user/v1/assign/coach/';
  static final String urlGetCoachesFeeds = baseUrl + 'api/feed/view/2';
  static final String urlGetClubFeeds= baseUrl + 'api/feed/view/1';
  static final String urlGetTeamFeeds = baseUrl + 'api/feed/view/3';
  static final String urlGetUSFeeds = baseUrl + 'api/feed/view/4';
  static final String urlAddClubPost= baseUrl + 'api/feed/1';
  static final String urlGetAllWorkOuts = baseUrl +'api/workout/v1/workouts';
  static final String urlLikePost= baseUrl + 'api/feed/like';
  static final String urlCommentPost= baseUrl + 'api/feed/comment';
  static final String urlGetComments= baseUrl + 'api/feed/comments/';
  static final String urlGetLikes= baseUrl + 'api/feed/likes/';
  static final String urlUpdateDP= baseUrl + 'api/user/v1/profile/image/';
  static final String urlAddCoachPost= baseUrl + 'api/feed/2';
  static final String urlAddTeamPost= baseUrl + 'api/feed/3';
  static final String urlAddUSPost= baseUrl + 'api/feed/4';
  static final String urlGetAllUsers = baseUrl+'api/chat/all/users';
  static final String urlGetNotifications = baseUrl+'api/user/v1/notifications/';
  static final String urlGetSponsors = baseUrl+'api/sponser/view';
  static final String urlAddWorkout = baseUrl+'api/workout/v1/add';
  static final String urlGetWorkoutHistory = baseUrl+'api/workout/v1/view';
  static final String urlGetWorkoutStats = baseUrl+'api/workout/v1/view-stats';
  static final String urlUpdateProfile = baseUrl+'api/user/v1/update/profile';
  static final String urlGetCoachWorkouts = baseUrl+'api/club/v1/coach/athletes';
  static final String urlGetCoachAthletes = baseUrl+'api/club/v1/coach/players';
  static final String urlAddEvent = baseUrl+'api/event';
  static final String urlGetClubEvents = baseUrl+'api/event/all';
  static final String urlGetUSEvents = baseUrl+'api/event/all/us';
  static final String urlGetTeamEvents = baseUrl+'api/event/all/team';
  static final String urlGetAttendants = baseUrl+'api/event/attendents';
  static final String urlSubEvent = baseUrl+'api/event/add';
  static final String urlGetTeamMembers = baseUrl+'api/team/v1/team/';
  static final String urlGetClubVideos = baseUrl+'api/video/club/view';
  static final String urlGetTeamVideos = baseUrl+'api/video/team/view';
  static final String urlGetCoachVideos = baseUrl+'api/video/coach/view';
  static final String urlAddClubVideo = baseUrl+'api/video/club';
  static final String urlAddTeamVideo = baseUrl+'api/video/team';
  static final String urlAddCoachVideo = baseUrl+'api/video/coach';
  static final String urlGetWorkoutActivities = baseUrl+'api/workout/v1/details';
  static final String urlGetWorkoutsActivities = baseUrl+'api/workout/v1/details-updated';
  static final String urlCoachHome = baseUrl+'api/home/coach';
  static final String urlAthleteHome = baseUrl+'api/home/athlete';
  static final String urlAllTeamsOfClubs = baseUrl+'api/club/v1/teams';
  static final String urlGetMyEvents = baseUrl+'api/event/coach';
  static final String urlGetUsVideo = baseUrl+'api/video/us-rowing/view';
  static final String urlAddUsVideo = baseUrl+'api/video/us-rowing';
  static final String urlAddChatMedia = baseUrl+'api/chat/media';
  static final String urlAddPdf = baseUrl+'api/library';
  static final String urlGetPdfs = baseUrl+'api/library/view';
  static final String urlVerifyOtp = baseUrl+'api/user/v1/verify/otp';
  static final String urlResetPassword = baseUrl+'api/user/v1/password/update';
  static final String urlVerifyEmail = baseUrl+'api/user/v1/email';
  static final String urlVerifyClub = baseUrl+'api/club/v1/verify';
  static final String urlIsAdmin = baseUrl+'api/user/v1/role/check/';
  static final String urlVerifyTeam = baseUrl+'api/team/v1/verify';
  static final String urlCreateGroup = baseUrl+'api/chat/group';
  static final String urlGetGroups = baseUrl+'api/chat/group/view';
  static final String urlAthleteEvents = baseUrl+'api/event/user/events';
  static final String urlGetUserInfo = baseUrl+'api/home/athlete/view';
  static final String urlSavePost = baseUrl+'api/feed/save/post';
  static final String urlSaveDoc = baseUrl+'api/library/save';
  static final String urlGetSavedPost = baseUrl+'api/feed/save/post/view';
  static final String urlGetSavedDoc = baseUrl+'api/library/save-view';
  static final String urlSaveMedia = baseUrl+'api/video/save-video';
  static final String urlGetSavedMedia = baseUrl+'api/video/save-video-view';
  static final String urlGetPostDetail = baseUrl+'api/feed/view-post-by-id';
  static final String urlGiveFeedback = baseUrl+'api/feedback';
  static final String urlSendVerificationCode = baseUrl+'api/user/v1/email-verification';

  //Equipment Reservation
  static final String urlGetCategories= baseUrl+ 'api/equipments/category-view';
  static final String urlGetEquipments= baseUrl+ 'api/equipments/equipment-view-by-category';
  static final String urlGetTimeSlots= baseUrl+ 'api/equipments/equipment-slots';
  static final String urlGetQuantity= baseUrl+ 'api/equipments/min-quantity-available';
  static final String urlGetQuantityRange= baseUrl+ 'api/equipments/min-quantity-available-range';
  static final String urlReserveSlot= baseUrl+ 'api/equipments/slot-reserve';
  static final String urlReserveDate= baseUrl+ 'api/equipments/reserve-for-days';
  static final String urlReserveDateRange= baseUrl+ 'api/equipments/reserve-for-multiple-days';
  static final String urlGetReservedList= baseUrl+ 'api/equipments/user-reservations';
  static final String urlCancelReservation= baseUrl+ 'api/equipments/slot-cancel-reservation';


  static final String urlDeletePost= baseUrl+ 'api/feed/delete-post';
  static final String urlDeleteMedia= baseUrl+ 'api/video/delete-video-view';
  static final String urlDeleteDoc= baseUrl+ 'api/feed/delete-post';


  //Concept2
  static final String urlSaveC2Email= baseUrl+ 'api/workout/v1/concept2/save-email';
  static final String urlCheckEmail= baseUrl+ 'api/workout/v1/concept2/save-check';

  //Club Search
  static final String urlGetSearchedAllClub = baseUrl + 'api/user/v1/club-search/';
  static final String urlGetSearchedAssignedClub = baseUrl + 'api/user/v1/club-search-assigned/';



}
