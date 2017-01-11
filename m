Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZE33DBQKGQEAUEHWSY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f142si25309wmf.2.2017.01.11.02.50.12
        for <rtc-linux@googlegroups.com>;
        Wed, 11 Jan 2017 02:50:12 -0800 (PST)
Date: Wed, 11 Jan 2017 11:50:12 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Amelie DELAUNAY <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Russell King <linux@armlinux.org.uk>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [rtc-linux] Re: [PATCHv3 3/8] rtc: add STM32 RTC driver
Message-ID: <20170111105012.ut6jxlmlf3qv37li@piout.net>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
 <20170111000803.mlie6kizcsj2o7lh@piout.net>
 <1feb3a23-7450-2b5c-9c1c-c7ecacd7fa17@st.com>
 <20170111101708.ujcgo7kpyywymyzp@piout.net>
 <ff7a532e-a2a7-920a-29d9-e8a82d6ed915@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <ff7a532e-a2a7-920a-29d9-e8a82d6ed915@st.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/01/2017 at 11:42:50 +0100, Amelie DELAUNAY wrote :
> 
> On 01/11/2017 11:17 AM, Alexandre Belloni wrote:
> > On 11/01/2017 at 11:07:16 +0100, Amelie DELAUNAY wrote :
> > > > This will never happen, tm is already checked multiple times (up to
> > > > three) in the core before this function can be called.
> > > > 
> > > You're right. I'll remove all rtc_valid_tm calls.
> > 
> > You can keep the one in read_time
> > 
> Even if rtc_valid_tm is called just after rtc->ops->read_time() in
> __rtc_read_time ?

Ah yes, I forgot it was added, you can remove all of them.

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
