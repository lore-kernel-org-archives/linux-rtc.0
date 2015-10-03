Return-Path: <rtc-linux+bncBDS7HNEFSALRBYPHX6YAKGQE3YXI7AY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id xl3si222925wib.1.2015.10.03.08.27.29
        for <rtc-linux@googlegroups.com>;
        Sat, 03 Oct 2015 08:27:29 -0700 (PDT)
Date: Sat, 3 Oct 2015 17:27:28 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Allessandro Zummo <a.zummo@towertech.it>,
	David Dajun Chen <david.chen@diasemi.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RTC <rtc-linux@googlegroups.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V1] rtc: GPL copyright inconsistency fix
Message-ID: <20151003152728.GD2694@piout.net>
References: <201510021025.t92AP2Bn026715@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <201510021025.t92AP2Bn026715@swsrvapps-01.diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/10/2015 at 11:21:11 +0100, Steve Twiss wrote :
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Fix misleading and inconsistent copyright header wording.
> 
> Alter the copyright header text and MODULE_LICENSE macro to ensure the
> GPL v2 licence description is correctly represented.
> 
> It will remove the incorrectly LGPL worded text. Words such as "Library"
> from the line "GNU Library General Public License"; and replace the word
> "library" with "program" in several other places.
> 
> The copyright should match the GPL v2 description as specified in the GNU
> license found here: http://www.gnu.org/licenses/gpl-2.0.html
> 
> It should also match this copyright text with the correct MODULE_LICENSE
> macro text as found in the kernel: include/linux/module.h
> In this case "GNU Public License v2 or later" is linked with "GPL".
> 

I would have though diasemi would stick to GPL 2 only.

> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> 
> This patch applies against linux-next and v4.3-rc3 
> 
> 
> 
>  drivers/rtc/rtc-da9063.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
