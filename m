Return-Path: <rtc-linux+bncBC2L7GMJYALRBE6VV62AKGQEAJEQHGY@googlegroups.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com. [2607:f8b0:400e:c00::22c])
        by gmr-mx.google.com with ESMTPS id t69si6339987pfi.1.2016.01.05.08.08.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2016 08:08:51 -0800 (PST)
Received: by mail-pf0-x22c.google.com with SMTP id 78so224878825pfw.2
        for <rtc-linux@googlegroups.com>; Tue, 05 Jan 2016 08:08:51 -0800 (PST)
Subject: [rtc-linux] Re: rtc-palmas: correct for bcd year
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1451508726-31769-1-git-send-email-salyzyn@android.com>
 <20160104161853.GC32724@piout.net> <568AA1C2.2070407@android.com>
 <20160105000000.GE32724@piout.net>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <568BEA92.2090701@android.com>
Date: Tue, 5 Jan 2016 08:08:50 -0800
MIME-Version: 1.0
In-Reply-To: <20160105000000.GE32724@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/04/2016 04:00 PM, Alexandre Belloni wrote:
> I'd say that the proper course of action is to refuse to set dates 
> before 2000 and after 2100. See http://patchwork.ozlabs.org/patch/541037/ 
Got it.

We have an issue though, Android (or rather any embedded) devices must 
continue to function when date is manually set to any value between 1970 
and 2037. The issue here is a fresh device with a recently charged 
battery will _start_ at 1970 until ntp or cell time/date/locale is set 
and the device must continue to function in this vacuum. A device reboot 
should not result in the other calendar values being reset, should the 
year be wrong, as this will result in a bad user experience.

We will have to use a different patch on Android than upstream if dates 
before 2000 are deprecated.

All other factors (rollover, leap) can be corrected by frameworks and 
runtime since the rtc is generally secondary (ie: first rtc driver was 
in 1979, created a daemon to correct the flaws in the hardware clock 
using a cron job)

Sincerely -- Mark Salyzyn

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
