Return-Path: <rtc-linux+bncBDA2J57FVMDBBS4V46VAKGQE5O2Q7BA@googlegroups.com>
Received: from sender1.zohomail.com (sender1.zohomail.com. [74.201.84.152])
        by gmr-mx.google.com with ESMTPS id xz5si1069630pac.1.2015.05.18.04.19.38
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 May 2015 04:19:38 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: [rtc-linux] Re: [RFC PATCH 1/2] Revert "rtc-cmos: Add an alarm
 disable quirk"
From: Brecht Machiels <brecht@mos6581.org>
In-Reply-To: <20150518101744.GF23662@pd.tnic>
Date: Mon, 18 May 2015 13:19:20 +0200
Cc: Adrian Huang <adrianhuang0701@gmail.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com,
 Thomas Gleixner <tglx@linutronix.de>,
 John Stultz <john.stultz@linaro.org>,
 Rabin Vincent <rabin.vincent@stericsson.com>,
 Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
 Adrian Huang <ahuang12@lenovo.com>
Message-Id: <92F16DED-397D-45B4-987A-491BCCBD0DB4@mos6581.org>
References: <1431077665-3493-1-git-send-email-adrianhuang0701@gmail.com> <20150518101744.GF23662@pd.tnic>
To: Borislav Petkov <bp@suse.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hello,

> On 18 May 2015, at 12:17, Borislav Petkov <bp@suse.de> wrote:
> 
> On Fri, May 08, 2015 at 05:34:25PM +0800, Adrian Huang wrote:
>> Commit d5a1c7e3fc38 ("rtc-cmos: Add an alarm disable quirk") that
>> added a special quirk is not needed because PATCH [2/2] of this
>> patchset makes the kernel more robust:
>> rtc: restore the RTC alarm time to the configured alarm time in BIOS
>> Setup
>> 
>> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
>> ---
>> drivers/rtc/rtc-cmos.c | 52 --------------------------------------------------
>> 1 file changed, 52 deletions(-)
> 
> ...
> 
>> -	/* http://permalink.gmane.org/gmane.linux.kernel/1604474 */
>> -	{
>> -		.callback = set_alarm_disable_quirk,
>> -		.ident    = "Toshiba Satellite L300",
>> -		.matches  = {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>> -			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L300"),
>> -		},
>> -	},
> 
> Looking at the link, this must be Brecht's box.
> 
> Brecht, is there any way you could test those patches? I'm attaching
> them here.

No, sorry, I'm no longer running Linux.

Best regards,
Brecht

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
