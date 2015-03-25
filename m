Return-Path: <akpm@linux-foundation.org>
Date: Wed, 25 Mar 2015 15:12:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
Subject: Re: [PATCH] MAINTAINERS: Add Alexandre Belloni as an RTC maintainer
Message-Id: <20150325151240.562e6fc6f43cceb51ab6c180@linux-foundation.org>
In-Reply-To: <1427320651-21356-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427320651-21356-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <rtc-linux.googlegroups.com>

On Wed, 25 Mar 2015 22:57:31 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Add myself as an RTC subsystem maintainer.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Hi,
> 
> I've noticed that most of the patches for the RTC subsystem are currently either
> taken directly by Andrew or going through another maintainer's tree, quite often
> without an Acked-by or Reviewed-by tag.
> I'd like to propose myself as the RTC susbsystem co-maintainer, to mainly help
> Alessandro reviewing incoming patches and maintain a subsystem tree to avoid
> having the RTC patches going through trees when they have no particular
> dependencies.
> 

Please start with
http://ozlabs.org/~akpm/mmots/broken-out/rtc-restore-alarm-after-resume.patch
;)

http://lkml.iu.edu/hypermail/linux/kernel/1412.2/03132.html
http://lkml.iu.edu/hypermail/linux/kernel/1501.0/01592.html
http://lkml.iu.edu/hypermail/linux/kernel/1501.0/01614.html
