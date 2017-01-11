Return-Path: <rtc-linux+bncBC2IT2GSZUDRBN4Y3DBQKGQECGE4GVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id e134si323669wmd.3.2017.01.11.02.43.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 02:43:02 -0800 (PST)
Subject: [rtc-linux] Re: [PATCHv3 3/8] rtc: add STM32 RTC driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-4-git-send-email-amelie.delaunay@st.com>
 <20170111000803.mlie6kizcsj2o7lh@piout.net>
 <1feb3a23-7450-2b5c-9c1c-c7ecacd7fa17@st.com>
 <20170111101708.ujcgo7kpyywymyzp@piout.net>
CC: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>
From: Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <ff7a532e-a2a7-920a-29d9-e8a82d6ed915@st.com>
Date: Wed, 11 Jan 2017 11:42:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170111101708.ujcgo7kpyywymyzp@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


On 01/11/2017 11:17 AM, Alexandre Belloni wrote:
> On 11/01/2017 at 11:07:16 +0100, Amelie DELAUNAY wrote :
>>> This will never happen, tm is already checked multiple times (up to
>>> three) in the core before this function can be called.
>>>
>> You're right. I'll remove all rtc_valid_tm calls.
>
> You can keep the one in read_time
>
Even if rtc_valid_tm is called just after rtc->ops->read_time() in 
__rtc_read_time ?

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
