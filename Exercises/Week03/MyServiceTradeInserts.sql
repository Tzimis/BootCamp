--Insert into tags values
--('lessons'), ('english'), ('math'), ('painting'), ('building');

--select * from Tags

--insert into Services (ServiceTitle, ServiceDescription, IndicativePrice)  values
--	 ('English Lessons Junior A',
--	 'Experienced professor teaches kids aged 5-7 visiting your place. Credits / hour of lesson.',
--	 15),
--	 ('Math Lessons Highschool',
--	 'Experienced maths teacher undertakes coaching highschool pupils. Credits / hour of lesson.',
--	 20),
--	 ('Painting Appartments',
--	 'Seasoned worker paints your place. Credits / square meter.',
--	 5);

--insert into Users(FirstName, LastName, UserName, Password, eMail, OwnedCredits) VALUES
--	('Bill', 'Gates', 'billy', '12345', 'billy@microsoft.com', 15),
--	('Paul', 'Allen', 'paul', '12345', 'paul@microsoft.com', 15),
--	('Steve', 'Wozniak', 'woz', '12345', 'woz@apple.com', 15);

--insert into Offers (ServiceID, OfferedBy, OfferDetails, CreditsRequested) VALUES
--	( 1, 1, 'I am Bill and I am a native English speaker!', 18),
--	( 1, 2, 'I am a native English speaker and I have a degree in Literature', 25),
--	( 3, 3, 'I have a thick beard', 3),
--	( 2, 3, 'Select me because I am an Engineer!', 25);

--insert into OffersTags (OfferID, TagID) VALUES
--	(1,2),
--	(1,1),
--	(2,2),
--	(2,1),
--	(4,1),
--	(4,3),
--	(3,5),
--	(3,4);

--select * from Offers; select * from Tags;

-- VIEW ALL OFFERS
--Select u.FirstName + ' ' + u.LastName as [Offered by], s.ServiceTitle, s.ServiceDescription, o.OfferDetails, t.TagText, o.CreditsRequested , s.IndicativePrice from Offers o
--join Users u on u.UserID = o.OfferedBy
--join Services s on s.ServiceID = o.ServiceID
--Join OffersTags ot on ot.OfferID = o.OfferID
--join tags t on ot.TagID = t.TagID

CREATE PROCEDURE [Get Tags by Title Substring] @Substring varchar(50) AS
select distinct t.TagText from OffersTags ot
join Tags t on t.TagID = ot.TagID
join Offers o on ot.OfferID = o.OfferID
join Services s on s.ServiceID = o.ServiceID
where s.ServiceTitle like '%' + @Substring + '%';

drop procedure [Get Tags by Title Substring];

exec [Get Tags by Title Substring] 'english';


