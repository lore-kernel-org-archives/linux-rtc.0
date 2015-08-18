Return-Path: <rtc-linux+bncBD2536XZRAKBBPXEZOXAKGQEWEIXHQA@googlegroups.com>
Received: from mail-lb0-x236.google.com (mail-lb0-x236.google.com. [2a00:1450:4010:c04::236])
        by gmr-mx.google.com with ESMTPS id ku1si579197lbc.3.2015.08.18.01.52.14
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2015 01:52:14 -0700 (PDT)
Received: by mail-lb0-x236.google.com with SMTP id bn3so97986215lbc.2
        for <rtc-linux@googlegroups.com>; Tue, 18 Aug 2015 01:52:14 -0700 (PDT)
Sender: rtc-linux@googlegroups.com
Date: Tue, 18 Aug 2015 10:52:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Keerthy <j-keerthy@ti.com>
Cc: alexandre.belloni@free-electrons.com, tony@atomide.com,
	johan@kernel.org, linux-omap@vger.kernel.org,
	rtc-linux@googlegroups.com, grygorii.strashko@ti.com
Subject: [rtc-linux] Re: [PATCH v4 0/2]  ARM: AM437X: Add rtc clock handling
Message-ID: <20150818085213.GA14209@localhost>
References: <1439887411-15576-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439887411-15576-1-git-send-email-j-keerthy@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, Aug 18, 2015 at 02:13:28PM +0530, Keerthy wrote:
> The series is applicable for all am437x series of processors.
> It adds clock handling support. Boot tested on am437x-gp-evm.
> 
> Keerthy (2):
>   ARM: dts: AM437x: Add the internal and external clock nodes for rtc
>   rtc: omap: Add external clock enabling support

Obsolete (2-patch) cover letter?

Either way, you should update the rtc-omap binding documentation with
the optional clocks as well.

Thanks,
Johan

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
