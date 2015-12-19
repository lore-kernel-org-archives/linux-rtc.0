Return-Path: <rtc-linux+bncBCJP7WOE5UIBBR6I2KZQKGQEXFGFGMA@googlegroups.com>
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com. [2607:f8b0:4002:c07::22c])
        by gmr-mx.google.com with ESMTPS id u184si245479ywf.0.2015.12.18.16.26.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2015 16:26:47 -0800 (PST)
Received: by mail-yk0-x22c.google.com with SMTP id 140so76900935ykp.0
        for <rtc-linux@googlegroups.com>; Fri, 18 Dec 2015 16:26:47 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <1450220569-10670-1-git-send-email-jwerner@chromium.org>
References: <CAODwPW_5WaLpqUeuJ0QhW=itgVq7iN_H3QH9_WzrVfsK+L-Rbg@mail.gmail.com>
	<1450220569-10670-1-git-send-email-jwerner@chromium.org>
Date: Fri, 18 Dec 2015 16:26:46 -0800
Message-ID: <CAD=FV=XrF0RcNwoyJr4c6Qg1H0sAfjYX3xcWHfO5ECt+TQuK5A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCHv3] RTC: RK808: Compensate for Rockchip
 calendar deviation on November 31st
From: Doug Anderson <dianders@chromium.org>
To: Julius Werner <jwerner@chromium.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Julius,

On Tue, Dec 15, 2015 at 3:02 PM, Julius Werner <jwerner@chromium.org> wrote:
> In A.D. 1582 Pope Gregory XIII found that the existing Julian calendar
> insufficiently represented reality, and changed the rules about
> calculating leap years to account for this. Similarly, in A.D. 2013
> Rockchip hardware engineers found that the new Gregorian calendar still
> contained flaws, and that the month of November should be counted up to
> 31 days instead. Unfortunately it takes a long time for calendar changes
> to gain widespread adoption, and just like more than 300 years went by
> before the last Protestant nation implemented Greg's proposal, we will
> have to wait a while until all religions and operating system kernels
> acknowledge the inherent advantages of the Rockchip system. Until then
> we need to translate dates read from (and written to) Rockchip hardware
> back to the Gregorian format.
>
> This patch works by defining Jan 1st, 2016 as the arbitrary anchor date
> on which Rockchip and Gregorian calendars are in sync. From that we can
> translate arbitrary later dates back and forth by counting the number
> of November/December transitons since the anchor date to determine the
> offset between the calendars. We choose this method (rather than trying
> to regularly "correct" the date stored in hardware) since it's the only
> way to ensure perfect time-keeping even if the system may be shut down
> for an unknown number of years. The drawback is that other software
> reading the same hardware (e.g. mainboard firmware) must use the same
> translation convention (including the same anchor date) to be able to
> read and write correct timestamps from/to the RTC.
>
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  drivers/rtc/rtc-rk808.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)

I'm not terribly worried about the date in the past problem that you
brought up in your own response.  So:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
