
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/AnswerWidget.dart';
import 'package:us_rowing/widgets/Expandable.dart';
import 'package:us_rowing/widgets/HeaderWidget.dart';
import 'package:us_rowing/widgets/QuestionWidget.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class FAQView extends StatefulWidget {
  @override
  _FAQViewState createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> {


  @override
  Widget build(BuildContext context)  {
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: SimpleToolbar(title: 'FAQs'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Container(
                      decoration: BoxDecoration(
                          color: colorBackgroundLight,
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Organizational Membership FAQs',
                              style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 16),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      )),
                  collapsed: SizedBox(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      HeaderWidget(
                        text: 'Basic FAQs',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Do I have to obtain a Basic membership in addition to my Championship membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'No. Basic membership is only the minimum membership requirement to participate in club activities and/or registered regattas (excludes USRowing hosted regattas).'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'What are the benefits of being an individual member?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'A list of benefits for all membership types can be found on our website.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text: 'What is the price of Basic membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Basic membership is free. An admin fee of \$9.75 will be assessed at checkout. Click here to read the full details.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(text: 'What is a Basic PLUS membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'The Basic PLUS membership was introduced in 2017 as an alternative to the Championship membership. Members can add-on a Regatta Package or a Coaches Package to their Basic, expanding their membership to include benefits previously only available to Championship members, such as eligibility to compete in USRowing hosted regattas, Excess Medical Coverage, and more!'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'What is the price of a Championship membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'For athletes 26 years old or younger, membership dues are \$45.00; for athletes 27 or older, membership dues are \$65.00. Individual memberships are rolling and last 365 days from the date of registration.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text: 'What is a rowing outreach membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'USRowing offers a Basic + Regatta Package membership at a reduced fee of \$9.75 per year to high school aged athletes who demonstrate economic need.'),
                      SizedBox(
                        height: 10,
                      ),
                      HeaderWidget(
                        text: 'Purchasing Your Membership',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text: 'How do I pay my individual membership dues?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Individual membership dues can be paid through the USRowing Membership Portal. If you are new to USRowing, click Join under Individuals. If you need to renew, go to Members and make one of the following selections: Sign In - log in with member # & password to renew or edit profile; Express Renew - \'log in\' using email/mobile & DOB to renew membership; or Express Waiver - \'log in\' using email/mobile & DOB to accept the online release of liability.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Can I cancel my membership if I am no longer rowing?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'While your membership can be canceled at any time, we will only refund money within the first 30 days of purchase, provided you have not competed at any regattas under that member number.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Can I cancel my membership if I am no longer rowing?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'While your membership can be canceled at any time, we will only refund money within the first 30 days of purchase, provided you have not competed at any regattas under that member number.'),
                      SizedBox(
                        height: 10,
                      ),
                      HeaderWidget(
                        text: 'Login & Credentials',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(text: 'What is my member number?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Use the member number look upto find your member number. If you are still having trouble, contact US Rowing at (609) 751-0700ormembers@usrowing.org.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(text: 'Can I reset my password?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Yes. If you do not remember your password, you can use the “Set/Reset Password” link located beside the green Submit button on the member Login page.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'I have multiple member numbers associated with my name. Which do I renew?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'It is possible to have multiple member numbers associated with your name. Perhaps you forgot a password and created a duplicate account, or have memberships under your full name as well as a nickname. Regardless, our system treats every member account as a separate individual. Call USRowing if you think this may be the case. To help remedy this for coaches, our improved roster management feature within the USRowing membership portal allows coaches to merge duplicate member accounts within a roster, provided that each has identical profile information. Note: if you have a championship membership and a basic membership, you should sign your waiver under the championship account.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Can I ‘revive’ an old member number and replace my current one?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Member numbers can be very meaningful (especially those lower ones). At this time we do not discard old numbers. If you are interested in renewing an old number, please contact membership at (609) 751-0700, and we will assist you in resurrecting your old number.'),
                      SizedBox(
                        height: 10,
                      ),
                      HeaderWidget(
                        text: 'Renewal',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'When should I renew my individual membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Memberships expire 365 days from when they are activated. It is recommended that you renew before your expiration date to ensure that your membership benefits do not lapse.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Where do I go to renew my individual membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Membership renewal can be done through the USRowing Membership Portal. Contact members@usrowing.org or (609) 751-0700 for assistance.'),
                      SizedBox(
                        height: 10,
                      ),
                      HeaderWidget(
                        text: 'Insurance',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'I am racing outside of the United States. Does my liability coverage apply?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Your USRowing coverage applies in the United States, Canada and Puerto Rico. If you are traveling outside of those territories and are in need of foreign liability coverage, as either an individual or as an organization, contact AssuredPartners at (610) 363-7999. Member organizations may be eligible to receive liability coverage at a premium of \$400 per trip. '),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  theme: ExpandableThemeData(
                    hasIcon: false,

                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Container(
                    decoration: BoxDecoration(
                        color: colorBackgroundLight,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Individual Membership FAQs',
                            style: TextStyle(
                                color: colorBlack,
                                fontSize: 16),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                  collapsed: SizedBox(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Where do I go to renew my organizational membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Organizational membership renewal is done through the USRowing Membership Portal.  To ensure your organization is receiving the proper notifications, be sure to make the any necessary changes to Contacts.  If you are unable to submit online payment, select the Mail Check option and an invoice will be sent to the Primary Contact on file.\nTo request a change in Administrators, download the Online Administrator Change Request Form and email a completed copy to organizations@USRowing.org or contact (609) 751-0706 for assistance.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'What is my RegattaCentral username and password?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'If you have forgotten or do not know the login credentials for the RegattaCentral account used to log in to the USRowing Membership Portal, visit www.regattacentral.com and use the \'Forgot Username or Password\' links to retrieve or reset them. Contact RC directly at (614) 360-2922 or support@regattacentral.com for assistance.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(text: 'What are my Admin Code and Token?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'The Admin Code and Token are used initially to assign the role of Administrator to a RegattaCentral account. While logged in to the USRowing Membership portal, click Add Organization and enter the admin code and token. Once the admin code and token have been used, you can add a role to or remove a role from another RC account under Roles.If you do not know the admin code and token for your organization and need to request a change in Administrators, download the Online Administrator Change Request Form and email a completed copy to organizations@USRowing.org or contact (609) 751-0706 for assistance.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Can I update my profile online or do I need to contact USRowing?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Organizations can log in to the USRowing Membership Portal to view or edit the information associated with their profile, such as physical or mailing address, contacts, facilities, and more. Click the Manage button in the footer of the profile to access the Organization Editor.If you have forgotten or do not know the login credentials for the RegattaCentral account used to log in to the USRowing Membership Portal, visit www.regattacentral.com and use the \'Forgot Username or Password\' links to retrieve or reset them. Contact RC directly at (614) 360-2922 or support@regattacentral.com for assistance.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'What are the different dues for being an organizational member?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Organizational membership dues vary depending on size, insurance needs, type, etc. Click HERE for a description of membership options and pricing.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'When do I have to renew my organizational membership?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Organizational membership is based on the calendar year and, unlike Individual Membership, expires on December 31st. Renewal for the coming year typically opens in November. It is strongly recommended that you renew the organizational membership as soon as possible to avoid any lapse in benefits, especially if the organization participates in the USRowing Insurance Program.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Do I have to be an individual member of USRowing as well as an organizational member?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Organizations must be active members of USRowing in order to participate in all USRowing registered or hosted regatta.Individuals who are members of or participate in rowing activities hosted by an organizational member of USRowing should be listed on the online team roster, hold at least Basic membership and accept the online waiver. This includes administrators, coaches, volunteers, and athletes.Individuals representing a member organization at a USRowing registered regatta should hold at least a Basic membership and accept the online waiver. Individuals racing as \'Unaffiliated\' must be either Basic + Add on Package (Regatta, Coach or Referee) or Championship members of USRowing and accept the online waiver.All Individuals participating in a USRowing hosted regatta (e.g Regional or National Championship regatta) must hold either a Basic + Add on Package (Regatta, Coach or Referee) or Championship membership and accept the online waiver. A list of those events can be found here.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Can I cancel my organizational membership if my club is no longer racing?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'While organizational membership can be canceled at any time, a refund will only be issued within the first 30 days of purchase. Once a member organization has participated in a USRowing registered regatta, they are no longer eligible for a refund regardless of the date of cancellation.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'I am part of an Alumni group that only wants to compete in a USRowing hosted or registered regatta.  What should I do?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Contact USRowing directly at (609) 751-0706 or organizations@usrowing.org to inquire about the special options for Alumni groups.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'USRowing requires individual membership, but I have an organizational membership.  Does that count as the same thing?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'No. If you are competing as an individual at an USRowing-hosted event, you are required to have a Basic + Add on Package (Regatta, Coach or Referee) or Championship Membership with a waiver on file. A list of those events can be found here. If you are racing as an individual at a registered regatta, you must have at least a Basic membership with a waiver on file.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'My club only races in the fall. Can I pay only half dues?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Contact us directly at (609) 751-0706 or organizations@usrowing.org.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'How do I obtain a Certificate of insurance (COI)?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Organizational members participating in the USRowing Insurance Program can visit www.AssuredPartners.com/USRowing to request a COI or contact Brandi Baldwin with AssuredPartners at brandi.baldwin@assuredpartners.com or (610) 363-7999.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(text: 'Where do I submit my roster?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'USRowing no longer requires Organizational Members to submit their roster. Rosters should be managed online through the USRowing Membership Portal. While the roster can be exported into Excel, it is intended for internal use only and not to be shared with other organizations as proof of USRowing compliance. Please note that it is not safe to share files containing the Personal Identifiable Information (PII), such as birth dates, emails, addresses, of your athletes through email. If you do need to share that type of data, we recommend using a file sharing service or text messaging.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'My team/organization is holding a fundraiser that will include individuals who are not part of our club (such as National Learn to Row Day or a Learn to Row event). Are we still covered?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Yes. Miscellaneous special events and activities that involve groups other than your members (or USRowing members) are included automatically with your membership subject to underwriting review. Please alert USRowing to any events you intend to host that require specific insurance coverage such as liquor, camps, etc.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Why would my organization need to become an organizational member of USRowing if our organization already has insurance elsewhere?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'The benefit of organizational membership level is to provide the opportunity to attend USRowing registered regattas. Many regattas are choosing to become registered events with USRowing for the specific event insurance coverage they receive, as well as the commitment of holding a fair and safe regatta. There are many benefits your organization is eligible for as a USRowing organization. Please visit the Organizational Membership - Standard Options page to learn more.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Our member organization also operates a canoe facility. Would its operations be covered under USRowing\'s insurance policy?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'More communities are expecting boathouses to be multi-purpose waterfront venues that serve a larger base. USRowing now offers multi water sport coverage options for organizational members. Coverage includes canoes, kayaks, and standup boards for an additional fee. We are still unable to cover exposure for dragon boats. Contact USRowing at (609) 751-0706 for more information on this coverage. '),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'What about other coverage that is not provided for my organization through USRowing?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'For more information about Directors & Officers, Automobile, Property or Rowing Equipment insurance, contact Rachel Kelley with AssuredPartners at (856) 996-1825 or rachel.kelley@assuredpartners.com for a competitive quote.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Is the sale of alcohol by our organization covered?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Should your organization provide liquor at a special event, a liquor application will need to be completed at an additional premium. All policies will be issued without liquor coverage until such time as events that need liquor coverage are endorsed. Contact Rachel Kelley with AssuredPartners at (856) 996-1825 or rachel.kelley@assuredpartners.com for more information.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Will my member organization be covered if I race in an international event?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'The USRowing Insurance Program provides coverage only in the United States, Canada, and Puerto Rico. If you are attending an event outside of these territories, please contact Rachel Kelley with AssuredPartners at (856) 996-1825 or rachel.kelley@assuredpartners.com to inquire about purchasing foreign liability coverage.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'Do all my members need to sign an electronic waiver?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'Yes. To fully comply with insurance requirements, all covered individuals should be listed on the online team roster and accept the online USRowing waiver. Contact USRowing Member Services at (609) 751-0706 or organizations@usrowing.org if you need assistance managing the online team roster.'),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionWidget(
                          text:
                              'What is SafeSport and what does it mean for our organization?'),
                      SizedBox(
                        height: 5,
                      ),
                      AnswerWidget(
                          text:
                              'We ask that all of our organizational members join USRowing in support of the SafeSport campaign to champion respect and end abuse. All USRowing organizational members are required to have a SafeSport policy and procedures document in place. While the primary focus is to safeguard children, policies should extend to all age groups including the masters and collegiate levels. Click HERE for more information on SafeSport.'),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  theme: ExpandableThemeData(
                    hasIcon: false,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                    header: Container(
                      decoration: BoxDecoration(
                          color: colorBackgroundLight,
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Organizational Membership FAQs',
                              style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 16),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                    collapsed: SizedBox(),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'As a referee, does my USRowing membership include insurance as a benefit?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Yes, your USRowing annual membership provides you with two forms of coverage: 1) liability insurance with a \$2,000,000 per occurrence limit; and 2) accident excess medical coverage of up to \$25,000 (with a \$250 deductible). The accident excess medical coverage is secondary to any primary insurance coverage you may have.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'If I am named in a lawsuit for an incident that occurred at an USRowing Registered Regatta, dual or tri between member organizations, am I covered?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Yes, a referee named personally in a lawsuit for their actions and brought by a participant in a registered regatta is covered, coverage falls under the General Liability Policy.  This policy has no â€œplayer vs. playerâ€ exclusion in the coverage and protects the referee for actions such as an alleged bad judgment call. This protects the referee and parallels the coverage USRowing Association has for itself and the regatta. *Please note that coverage does not extend to incidents during activities at non-USRowing Registered Regattas, or duals and tris between non-member organizations.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'Dont I have liability coverage for my referee activity under my Homeowners/Tenant Insurance policy?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'You may or may not have coverage under your Homeowners/Tenants Insurance policy for this. You should discuss the topic with your agent to confirm. Note that, for the fee you pay to USRowing for membership, you do receive this protection in addition to the other of USRowing benefits provided to our members.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'What if I am injured while participating in an USRowing Registered Regatta, dual, or tri between member organizations?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'As a member of USRowing, you hold a \$25,000 (with a \$250 deductible) excess accident medical benefit; \$15,000 of accidental death; and \$50,000 of dismemberment coverage. This policy is excess to any primary insurance. *Please note that coverage does not extend to incidents during activities at non-USRowing Registered Regattas, or dials and tris between non-member organizations.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'Why would I need coverage when I have health insurance through another source, such as my employer?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Your health insurance may not cover all of the expenses associated with your refereeing injury.  If your health insurance covers only part of your medical bills, and you have out-of-pocket expenses or deductibles that are not covered, you may submit those expenses for consideration under the USRowing plan.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'If I am without primary insurance and I am injured while refereeing, do I have coverage?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Yes, the accident policy will respond as primary in the absence of other insurance, provided that the accident occurred during an USRowing Registered Regatta, dual, or tri between member organizations and meets all of the definitions for coverage under the policy.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'Who should sign a release of liability form?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Every referee should sign a waiver before the beginning of their season. When a referee joins USRowing as a full-privileged member, they are required to sign the annual release form. This release will apply to all USRowing club and regatta activities that an individual participates in during the year.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'If I am refereeing at a non-USRowing Registered Regatta, do I have coverage?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'No. Coverage applies only to USRowing Registered Regattas, or duals and tris between member organizations. If you are injured, or named in a lawsuit this policy does not provide you with protection for officiating. The Registered Regatta Program was developed to ensure that standards are being implemented for safety and fair play. Although there are quality regattas that are not registered, USRowing cannot assume the responsibility for how non-registered events are conducted.'),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  theme: ExpandableThemeData(
                    hasIcon: false,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                    header: Container(
                      decoration: BoxDecoration(
                          color: colorBackgroundLight,
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Referee Data System FAQ',
                              style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 16),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                    collapsed: SizedBox(),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(text: 'How do I get to RefCorps'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                ' Go to https://usrowing.force.com/refcorps and login with your username and password. Your username is your email address on file.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'I dont remember my user name or password?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Please contact Jules Zane at jules.zane@usrowing.org for your username. If you forgot your password, click Forgot Your Password for a reset link.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'What is the purpose of completing the annual data call?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'The purpose of completing the data call is to document the regattas worked and clinics attended to ensure that you have completed the basic requirements to maintain your referee license. RefCorps also is a place to express interest in attending a national championship, trials event or the annual referee college, when those windows are open.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'When is the annual data call and what time frame does it cover?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'The annual data call is due by September 30 of each year. The call covers the regatta data vall year, which runs from September 1 to August 31.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'I entered all my data, how do I submit it?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'You do not have to formally submit your information through the system. As long as all regatta and clinic attendance is listed, the data will be collected at the deadline and shared with the regional coordinators.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'What about regattas I worked or clinics I attended in September?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'You may add them to your lists now since you are already accessing the system to complete you call. They wont be tabulated into the totals for the data call year, but they will already be sorted for you for the next years call. The system is up all year, so you may find it useful to enter you regattas and clinics as you attended them rather than trying to remember what you worked months later. The system is set to not allow you to enter a regatta as worked until the day it starts. So you can add it to the searchable list, but not your own listing until the first day of the regatta or clinic.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'I have already completed the data call and realized I forgot a regatta or clinic. What do I do?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'As long as the deadline has not passed, you can update your information in RefCorps. Because your data is not submitted or collected by USRowing until the deadline, you can continue to make changes.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'I added all my clinics and regattas; am I done with the data call?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Likely, yes. However, other information may be requested later in the year, such as your interest in working National Championships. If those requests are currently being collected in the system, we will inform you via email.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                ' If my address or other contact information changes later in the year, what do I do?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'USRowing asks that you update your address and contact information both in RefCorps and the regular USRowing Member Database. At this time, they do not directly communicate changes between each other. If you are moving to a different region, please contact Jules Zane at jules.zane@usrowing.org and additionally contact your regional coordinator.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'If I express an interest in working one or more of the nationals at the time of the call, does that mean I have to work if selected?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'No, you will be able to pull out if selected if the regatta dates don\'t fit your schedule. Obviously, dont put your name down as interested in a regatta that you have no intention of working. However, given that schedules change, some staffing changes are expected.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'Where is the form for filling out the regional evaluations?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                ' Further instructions regarding the clinician evaluations are to follow for RefCorps. The development team is close to releasing the feature. '),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  theme: ExpandableThemeData(
                    hasIcon: false,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                    header: Container(
                      decoration: BoxDecoration(
                          color: colorBackgroundLight,
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Rowing Quick Facts',
                              style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 16),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                    collapsed: SizedBox(),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        AnswerWidget(
                            text:
                                '•	Rowing is one of the original sports in the modern Olympic Games.\n'
                                '•	Baron Pierre de Coubertin, founder of the modern Olympics, was a rower.\n'
                                '•	Rowers are the third largest U.S. delegation (48 athletes) to the Olympic Games.\n'
                                '•	Eight-oared shells are about 60-feet long – that\'s 20 yards on a football field.\n'
                                '•	Rowing was the first intercollegiate sport contested in the United States. The first rowing race was between Harvard and Yale in 1852.\n'
                                '•	Physiologically, rowers are superb examples of physical conditioning. Cross-country skiers and long distance speed skaters are comparable in terms of the physical demands the sport places on the athletes.\n'
                                '•	An eight, which carries more than three-quarters of a ton (1,750 pounds), may weigh as little as 200 pounds. The boats are made of fiberglass composite material.\n'
                                '•	Singles may be as narrow as 10 inches across, weigh only 23 pounds, and stretch nearly 27-feet long.\n'
                                '•	The first rowing club in the U.S. was the Detroit Boat Club, founded in 1839.\n'
                                '•	The first amateur sport organization was a rowing club – Philadelphia\'s Schuylkill Navy, founded in 1858.\n'
                                '•	From 1920 until 1956, the USA won the gold medal in the men\'s eight at every Olympic Games.\n'
                                '•	The first national governing body for a sport in the United States was for rowing. Founded as the National Association for Amateur Oarsmen in 1872, it was changed in 1982 to the United States Rowing Association.\n'
                                '•	Yale College founded the first collegiate boat club in the U.S. in 1843.\n'
                                '•	FISA, the first international sports federation, was founded in 1892.\n'
                                '•	Dr. Benjamin Spock, the famous baby doctor, was an Olympic rower in 1924 and won a gold medal in the eight. Gregory Peck rowed at the University of California in 1937.\n'
                                '•	Physiologists claim that rowing a 2,000-meter race – equivalent to 1.25 miles – is equal to playing back-to-back basketball games.\n'
                                '•	In 1997, Jamie Koven became the first American to win the men\'s single sculls at the world championships since 1966.\n'
                                '•	In 1999, the U.S. men\'s eight won its third consecutive gold medal at the world championships, a first in U.S. history.\n'
                                '•	In 2004, the U.S. men\'s eight won gold at the Olympic Games.\n'
                                '•	In 2008, the U.S. won gold in the women\'s eight at the Olympic Games.\n'
                                '•	At the 2012 London Olympic Games, the U.S. women\'s eight won gold for a second consecutive Olympics. At the Paralympics, the U.S. won bronze in the trunk and arms mixed double, a first in U.S. history.\n'
                                '•	At the 2016 Rio Olympics, the U.S. women\'s eight won gold for the third consecutive Olympics, and the women\'s single sculls won silver. At the Paralympics, the U.S. won silver in the legs, trunk and arms four.\n'
                                '•	The women\'s eight victory in 2016 at the Olympics extended its world-title winning streak to 11 consecutive years.\n'),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  theme: ExpandableThemeData(
                    hasIcon: false,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                    header: Container(
                      decoration: BoxDecoration(
                          color: colorBackgroundLight,
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Shop US Rowing',
                              style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 16),
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                    collapsed: SizedBox(),
                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        HeaderWidget(
                          text: 'SHIPPING',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text: 'How Long Does Shipping Take?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Most of our items are fulfilled within 1-4 business days. However, since we do utilize different suppliers, some products will be shipped on different days and from different locations! You will receive a notification with each item\'s tracking number ( should they be dispatched from different suppliers).'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'I Need My Order By A Certain Date. Will It Arrive On Time?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'Our products are shipped from different suppliers. Should you require your order by a short deadline, we encourage you to email us first to avoid disappointments and work out a better solution for you!'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text: 'Where Is My Tracking Number?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'You will receive a notification via email once each order has been dispatched. Since some items are shipped by different suppliers, you might receive multiple tracking numbers for a single order.\nIf you are not able to find your tracking number please email us at shop@usrowing.org'),
                        SizedBox(
                          height: 10,
                        ),
                        HeaderWidget(
                          text: 'JEWELRY',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(text: 'Can You Engrave My Jewelry?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'We can engrave most of our pieces with 4-6 characters max. Look out for the option on each product listing. Engraving costs \$15.'),
                        SizedBox(
                          height: 10,
                        ),
                        HeaderWidget(
                          text: 'EXCHANGES AND REFUNDS',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(text: 'EXCHANGES WITHIN 30 DAYS:'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'We can exchange your items. Buyer is responsible for the return fees!\nTo begin please email us with:\n- Order Number or Full Name\n- Preferred Item'),
                        SizedBox(
                          height: 5,
                        ),
                        QuestionWidget(
                            text:
                                'NOTE: Engraved Jewelry is not exchangeable or refundable unless there is a fault or incorrect engraving.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(text: 'REFUNDS WITHIN 30 DAYS :'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'We can refund your items. Buyer is responsible for the return fees!\nPlease email us  and we will initiate the process!'),
                        SizedBox(
                          height: 5,
                        ),
                        QuestionWidget(
                            text:
                                'NOTE: Items must be returned in its original package and intact.'),
                        SizedBox(
                          height: 10,
                        ),
                        QuestionWidget(
                            text:
                                'Can I Get A Refund or Exchange after 30 days?'),
                        SizedBox(
                          height: 5,
                        ),
                        AnswerWidget(
                            text:
                                'If 30 days have gone by, we won\'t be able to refund or exchange any piece.'),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  theme: ExpandableThemeData(
                    hasIcon: false,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
