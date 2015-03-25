Return-Path: <a.zummo@towertech.it>
Date: Wed, 25 Mar 2015 23:58:09 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Subject: Re: [PATCH] MAINTAINERS: Add Alexandre Belloni as an RTC maintainer
Message-ID: <20150325235809.22f1c441@linux.lan.towertech.it>
In-Reply-To: <1427320651-21356-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427320651-21356-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <rtc-linux.googlegroups.com>

On Wed, 25 Mar 2015 22:57:31 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> I'd like to propose myself as the RTC susbsystem co-maintainer, to mainly help
> Alessandro reviewing incoming patches and maintain a subsystem tree to avoid
> having the RTC patches going through trees when they have no particular
> dependencies.

 Thanks :)

 A few things I consider important:

 - a driver for a new hardware usually causes no harm to the subsystem

 - a patch for an existing driver should be approved by the original author,
 if possible. there are a few chips out there that are quite rare or
 have multiple wiring configuration and break very easily.

-- 

 Best regards,

 Alessandro Zummo - CEO,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
