public class Data_Access_User_cls {
    /**
    * @description
    * @author eduardo.villegas@engeniumcapital.com | 10/7/2019
    * @param String recordId
    * @return List<Takedown_Invoice__c>
    */
    @AuraEnabled(Cacheable=false)
    public static User getUser(id recordId){
        List<User> listUser = new List<User>();
        if (Schema.sObjectType.User.isAccessible()){
            for(User usuario : [SELECT Id, Username, LastName, FirstName, MiddleName, Name, CompanyName, Division, 
                    Department, Title, Street, City, State, PostalCode, Country, StateCode, CountryCode, 
                    Latitude, Longitude, GeocodeAccuracy, Address, Email, EmailPreferencesAutoBcc, 
                    EmailPreferencesAutoBccStayInTouch, EmailPreferencesStayInTouchReminder, SenderEmail, 
                    SenderName, Signature, StayInTouchSubject, StayInTouchSignature, StayInTouchNote, 
                    Phone, Fax, MobilePhone, Alias, CommunityNickname, BadgeText, IsActive, TimeZoneSidKey, 
                    UserRoleId, LocaleSidKey, ReceivesInfoEmails, ReceivesAdminInfoEmails, EmailEncodingKey, 
                    DefaultCurrencyIsoCode, CurrencyIsoCode, ProfileId, Profile.name, UserType, LanguageLocaleKey, EmployeeNumber, 
                    DelegatedApproverId, ManagerId, LastLoginDate, CreatedDate, CreatedById, 
                    LastModifiedDate, LastModifiedById, SystemModstamp,  OfflineTrialExpirationDate, 
                    OfflinePdaTrialExpirationDate, UserPermissionsMarketingUser, UserPermissionsOfflineUser, UserPermissionsAvantgoUser, 
                    UserPermissionsCallCenterAutoLogin, UserPermissionsMobileUser, UserPermissionsSFContentUser, 
                    UserPermissionsInteractionUser, UserPermissionsSupportUser, UserPermissionsChatterAnswersUser, 
                    ForecastEnabled, UserPreferencesActivityRemindersPopup, UserPreferencesEventRemindersCheckboxDefault, 
                    UserPreferencesTaskRemindersCheckboxDefault, UserPreferencesReminderSoundOff, UserPreferencesDisableAllFeedsEmail, 
                    UserPreferencesDisableFollowersEmail, UserPreferencesDisableProfilePostEmail, UserPreferencesDisableChangeCommentEmail, 
                    UserPreferencesDisableLaterCommentEmail, UserPreferencesDisProfPostCommentEmail, UserPreferencesContentNoEmail, 
                    UserPreferencesContentEmailAsAndWhen, UserPreferencesApexPagesDeveloperMode, UserPreferencesReceiveNoNotificationsAsApprover, 
                    UserPreferencesReceiveNotificationsAsDelegatedApprover, UserPreferencesHideCSNGetChatterMobileTask, 
                    UserPreferencesDisableMentionsPostEmail, UserPreferencesDisMentionsCommentEmail, UserPreferencesHideCSNDesktopTask, 
                    UserPreferencesHideChatterOnboardingSplash, UserPreferencesHideSecondChatterOnboardingSplash, 
                    UserPreferencesDisCommentAfterLikeEmail, UserPreferencesDisableLikeEmail, UserPreferencesSortFeedByComment, 
                    UserPreferencesDisableMessageEmail, UserPreferencesDisableBookmarkEmail, UserPreferencesDisableSharePostEmail, 
                    UserPreferencesEnableAutoSubForFeeds, UserPreferencesDisableFileShareNotificationsForApi, 
                    UserPreferencesShowTitleToExternalUsers, UserPreferencesShowManagerToExternalUsers, 
                    UserPreferencesShowEmailToExternalUsers, UserPreferencesShowWorkPhoneToExternalUsers, 
                    UserPreferencesShowMobilePhoneToExternalUsers, UserPreferencesShowFaxToExternalUsers, 
                    UserPreferencesShowStreetAddressToExternalUsers, UserPreferencesShowCityToExternalUsers, 
                    UserPreferencesShowStateToExternalUsers, UserPreferencesShowPostalCodeToExternalUsers, 
                    UserPreferencesShowCountryToExternalUsers, UserPreferencesShowProfilePicToGuestUsers, 
                    UserPreferencesShowTitleToGuestUsers, UserPreferencesShowCityToGuestUsers, UserPreferencesShowStateToGuestUsers, 
                    UserPreferencesShowPostalCodeToGuestUsers, UserPreferencesShowCountryToGuestUsers, 
                    UserPreferencesPipelineViewHideHelpPopover, UserPreferencesHideS1BrowserUI, 
                    UserPreferencesDisableEndorsementEmail, UserPreferencesPathAssistantCollapsed, 
                    UserPreferencesCacheDiagnostics, UserPreferencesShowEmailToGuestUsers, 
                    UserPreferencesShowManagerToGuestUsers, UserPreferencesShowWorkPhoneToGuestUsers, 
                    UserPreferencesShowMobilePhoneToGuestUsers, UserPreferencesShowFaxToGuestUsers, 
                    UserPreferencesShowStreetAddressToGuestUsers, UserPreferencesLightningExperiencePreferred,
                    UserPreferencesPreviewLightning, UserPreferencesHideEndUserOnboardingAssistantModal, 
                    UserPreferencesHideLightningMigrationModal, UserPreferencesHideSfxWelcomeMat, 
                    UserPreferencesHideBiggerPhotoCallout, UserPreferencesGlobalNavBarWTShown, 
                    UserPreferencesGlobalNavGridMenuWTShown, UserPreferencesCreateLEXAppsWTShown, 
                    UserPreferencesFavoritesWTShown, UserPreferencesRecordHomeSectionCollapseWTShown, 
                    UserPreferencesRecordHomeReservedWTShown, UserPreferencesFavoritesShowTopFavorites, 
                    UserPreferencesExcludeMailAppAttachments, UserPreferencesSuppressTaskSFXReminders, 
                    UserPreferencesSuppressEventSFXReminders, UserPreferencesPreviewCustomTheme, 
                    UserPreferencesHasCelebrationBadge, UserPreferencesUserDebugModePref, 
                    UserPreferencesSRHOverrideActivities, UserPreferencesNewLightningReportRunPageEnabled, ContactId, 
                    AccountId, CallCenterId, Extension, FederationIdentifier, AboutMe, FullPhotoUrl, SmallPhotoUrl, 
                    IsExtIndicatorVisible, OutOfOfficeMessage, MediumPhotoUrl, DigestFrequency, DefaultGroupNotificationFrequency, 
                    LastViewedDate, LastReferencedDate, BannerPhotoUrl, SmallBannerPhotoUrl, MediumBannerPhotoUrl, 
                    IsProfilePhotoActive, IndividualId, USU_ls_Line_of_Business__c, USU_ls_Region__c, USU_ls_Vertical__c, 
                    Engenium_Capital_Office__c, Loop__LOOPlus_Tester__c, Volume_Target__c, Gross_Margin_Target__c, Calendly__c, 
                    Qlik_Password__c, Loop__dsPassword__c, Loop__dsToken__c, Entry_Date__c, User_Signature_Photo__c, 
                    Date_started_current_position__c, dsfs__DSProSFUsername__c, Engenium_Area_Logo__c, Engenium_Area_Header__c 
                    FROM User where id = :recordId]){
                listUser.add(usuario);
                    } 
            
        } else {
                        System.debug(LoggingLevel.ERROR,'You dont have permission');
                        return null;
                    }
        return listUser.size() > 0 ? listUser.get(0) : null;
    }

}