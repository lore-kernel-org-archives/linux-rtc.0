Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBK7B2DBQKGQE5VY76FA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si21910wmd.3.2017.01.09.16.54.03
        for <rtc-linux@googlegroups.com>;
        Mon, 09 Jan 2017 16:54:03 -0800 (PST)
Date: Tue, 10 Jan 2017 01:54:02 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Emil Bartczak <emilbart@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 0/2] Provides support for alarm.
Message-ID: <20170110005402.3hqexgtfbrjb2tz3@piout.net>
References: <1482703663-9115-1-git-send-email-emilbart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1482703663-9115-1-git-send-email-emilbart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 25/12/2016 at 23:07:41 +0100, Emil Bartczak wrote :
> This patchset provides support for weekday and alarm 
> in the file driver/rtc/rtc-mcp795.c. 
> Please review the changes and consider to apply them to the main kernel tree.
> 
> Changes from v1:
> - Cover letter added.
> 
> Emil Bartczak (2):
>   rtc: mcp795: Add support for weekday.
>   rtc: mcp795: add alarm support.
> 
>  drivers/rtc/rtc-mcp795.c | 183 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 177 insertions(+), 6 deletions(-)
> 

Matching the alarm on weekday, how awful...

Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
