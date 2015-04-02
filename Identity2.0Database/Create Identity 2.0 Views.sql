
/*
These instructions where helpful
http://michaelcrump.net/setting-up-github-to-work-with-visual-studio-2013-step-by-step
*/

USE IdentityDb
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwRoles]
AS

/*
List the roles in the AspNet* tables along with thier users
SELECT * FROM vwRoles ORDER BY RoleName
*/

SELECT r.Name AS RoleName, r.Id,
  (SELECT u.UserName + ', '
   FROM AspNetUsers u, AspNetUserRoles ur 
	 WHERE  u.Id = ur.UserId AND r.Id = ur.RoleId
   FOR XML PATH('') 
  ) AS Users
FROM AspNetRoles AS r


/*



*/

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwUsers]
AS

/*
List the users in the AspNet* tables along with thier Roles
SELECT * FROM vwUsers ORDER BY UserName
*/

SELECT u.UserName, u.Email,
  (SELECT r.Name + ', '
   FROM AspNetRoles r, AspNetUserRoles ur 
	 WHERE  r.Id = ur.RoleId AND u.Id = ur.UserId
   FOR XML PATH('') 
  ) AS Roles
	, u.EmailConfirmed, u.Id, u.PhoneNumberConfirmed, u.PhoneNumber 
FROM AspNetUsers AS u


GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwUsersAndThereRoles]
AS

/*
List the terms so that it can be easily consumed by the Glossary Grid
SELECT * FROM vwUsersAndThereRoles ORDER BY UserName
*/


SELECT u.Id, u.Email, u.EmailConfirmed, u.PhoneNumber, u.PhoneNumberConfirmed, u.UserName, r.Id AS RoleId, r.Name AS RoleName
FROM            
	dbo.AspNetRoles AS r 
		INNER JOIN dbo.AspNetUserRoles AS ur 	ON r.Id = ur.RoleId 
		RIGHT OUTER JOIN dbo.AspNetUsers AS u ON ur.UserId = u.Id
GO

