Return-Path: <rtc-linux+bncBAABBMNGV2YAKGQE2AZDCSQ@googlegroups.com>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com. [195.245.230.161])
        by gmr-mx.google.com with ESMTPS id c7si826427wiy.3.2015.09.30.00.45.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2015 00:45:52 -0700 (PDT)
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>, DEVICETREE <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala
	<galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Pawel
 Moll" <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob
 Herring <robh+dt@kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Samuel Ortiz <sameo@linux.intel.com>, Support Opensource
	<Support.Opensource@diasemi.com>
Subject: [rtc-linux] RE: [PATCH V3 3/3] devicetree: da9062: Add device tree
 bindings for DA9062 OnKey
Date: Wed, 30 Sep 2015 07:45:50 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70173D13566@SW-EX-MBX02.diasemi.com>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws> <20150728054024.GA4558@dtor-ws>
 <6ED8E3B22081A4459DAC7699F3695FB70173D121FD@SW-EX-MBX02.diasemi.com>
 <20150929235408.GC29469@dtor-ws>
In-Reply-To: <20150929235408.GC29469@dtor-ws>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 30 September 2015 00:54 Dmitry Torokhov wrote:

> To: Opensource [Steve Twiss]
> Cc: Lee Jones; DEVICETREE; Ian Campbell; Kumar Gala; LINUXINPUT;
> LINUXKERNEL; Mark Rutland; Pawel Moll; RTCLINUX; Rob Herring; David
> Dajun Chen; Samuel Ortiz; Support Opensource
> Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for
> DA9062 OnKey
> 
> On Mon, Sep 28, 2015 at 08:19:27AM +0000, Opensource [Steve Twiss]
> wrote:
> >
> > Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings
> > for DA9062 OnKey
> >
> > Hi Lee and Dmitry,
> >
> > This patch seems to have been missed. It is the main OnKey driver for
> > DA9062 and this
> > component was waiting for the DA9062 MFD core to make it into linux-
> > mainline/v4.3-rc1.
> >
> >
> 
> I queued it for 4.4.
> 
> Thanks.
> 
> --
> Dmitry

Hi Dmitry,
I can see it in your repo now.
(a27b5e0 Input: add DA9062 OnKey capability to DA9063 OnKey driver)
Thanks for your efforts on this patch.
Regards,
Stephen

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
