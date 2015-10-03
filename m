Return-Path: <rtc-linux+bncBDS7HNEFSALRBC5FX6YAKGQELYW77TA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bj4si104023wib.1.2015.10.03.06.05.14
        for <rtc-linux@googlegroups.com>;
        Sat, 03 Oct 2015 06:05:14 -0700 (PDT)
Date: Sat, 3 Oct 2015 15:05:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Ivan Grimaldi <grimaldi.ivan@gmail.com>
Cc: a.zummo@towertech.it, mpfj@mimc.co.uk, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 2/2] Added trickle charger device tree binding
Message-ID: <20151003130513.GG10444@piout.net>
References: <1442589759-29538-1-git-send-email-grimaldi.ivan@gmail.com>
 <1442589759-29538-2-git-send-email-grimaldi.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1442589759-29538-2-git-send-email-grimaldi.ivan@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 18/09/2015 at 17:22:39 +0200, Ivan Grimaldi wrote :
> Introduce a device tree binding for specifying the trickle charger
> configuration for ds1339.
> 
> Signed-off-by: Ivan Grimaldi <grimaldi.ivan@gmail.com>
> ---
>  .../devicetree/bindings/rtc/dallas,ds1390.txt      | 18 +++++++
>  drivers/rtc/rtc-ds1390.c                           | 62 ++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1390.txt
> 
Applied, after doing a few whitespace modifications, thanks.

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
