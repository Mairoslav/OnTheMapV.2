//
//  PublicUserDataResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 07/12/2022.
//

import Foundation

struct PublicUserDataResponse: Codable {
    
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
}

// 11. Udacity API: GETting Public User Data
// Example JSON Response from: https://video.udacity-data.com/topher/2016/June/575840d1_get-user-data/get-user-data.json

/*
 {
     "user":{
         // MARK: "last_name":"Doe",
         "social_accounts":[

         ],
         "mailing_address":null,
         "_cohort_keys":[

         ],
         "_signature":null,
         "_stripe_customer_id":null,
         "guard":{
             "can_edit":true,
             "permissions":[
                 {
                     "derivation":[
                         "synthetic"
                     ],
                     "behavior":"view-customer",
                     "principal_ref":{
                         "ref":"ScopedRole",
                         "key":"staff\\3aglobal"
                     }
                 },
                
                 ... deleted ... 
 
         "_facebook_id":null,
         "timezone":null,
         "site_preferences":null,
         "occupation":null,
         "_image":null,
         // MARK: "first_name":"John",
         "jabber_id":null,
         "languages":null,
         "_badges":[

         ],
         "location":null,
         "external_service_password":null,
         "_principals":[
             "email verified\\3aglobal",
             "registered user\\3aglobal",
             "everyone\\3aglobal",
             "3903878747"
         ],
         "_enrollments":[

         ],
         "email":{
             "_verification_code_sent":true,
             "_verified":true,
             "address":"john.doe.udacity.user@gmail.com"
         },
         "website_url":null,
         "external_accounts":[

         ],
         "bio":null,
         "coaching_data":null,
         "tags":[

         ],
         "_affiliate_profiles":[

         ],
         "_has_password":true,
         "email_preferences":{
             "ok_user_research":true,
             "master_ok":true,
             "ok_course":true
         },
         "_resume":null,
         "key":"3903878747",
         "nickname":"John",
         "employer_sharing":true,
         "_memberships":[
             {
                 "current":true,
                 "group_ref":{
                     "ref":"ScopedRole",
                     "key":"everyone\\3aglobal"
                 },
                 "creation_time":null,
                 "expiration_time":null
             }
         ],
         "zendesk_id":null,
         "_registered":true,
         "linkedin_url":null,
         "_google_id":null,
         "_image_url":"//robohash.org/udacity-3903878747.png"
     }
 }
 */
