Return-Path: <rtc-linux+bncBAABBKPKXHBAKGQE2GEU3TQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id l206si2210967wmf.2.2016.12.12.02.00.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 02:00:09 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 3/8] rtc: add STM32 RTC driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
 <1480687801-19525-5-git-send-email-amelie.delaunay@st.com>
 <20161202175646.GA3284@linaro.org>
 <15bea9e9-adcc-edb0-1bd1-33d395c72eec@st.com>
 <20161207183709.tbkapu34ljlg4skp@piout.net>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>,
        "a.zummo@towertech.it"
	<a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
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
Message-ID: <a2d3ddc0-c8f6-0f42-ad33-a92e0ac6aee4@st.com>
Date: Mon, 12 Dec 2016 10:59:51 +0100
MIME-Version: 1.0
In-Reply-To: <20161207183709.tbkapu34ljlg4skp@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On 12/07/2016 07:37 PM, Alexandre Belloni wrote:
> On 05/12/2016 at 10:43:14 +0100, Amelie DELAUNAY wrote :
>>>> +
>>>> +    device_init_wakeup(&pdev->dev, true);
>>>
>>> What happens if device_init_wakeup() returns an error?
>> It means that RTC won't be able to wake up the board with RTC alarm. I can
>> add a warning for the user in this case ?
>>>
>
> There is exactly one driver ever checking the return value of
> device_init_wakeup(). It basically always succeeds.
>
>
OK so, is it OK for everyone that I bet on the fact that it will always 
succeed?

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
