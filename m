Return-Path: <rtc-linux+bncBDENZBE5PQIOTL5NVYCRUBAA5MVCW@googlegroups.com>
Received: from utopia.booyaka.com (utopia.booyaka.com. [74.50.51.50])
        by gmr-mx.google.com with ESMTPS id f17si1504524igt.0.2015.08.12.07.27.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 07:27:52 -0700 (PDT)
Date: Wed, 12 Aug 2015 14:27:49 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Keerthy <j-keerthy@ti.com>
cc: tony@atomide.com, linux-omap@vger.kernel.org, pawel.moll@arm.com,
  galak@codeaurora.org, alexandre.belloni@free-electrons.com,
  akpm@linux-foundation.org, johan@kernel.org, grygorii.strashko@ti.com,
  rtc-linux@googlegroups.com, bcousson@baylibre.com, nm@ti.com,
  devicetree@vger.kernel.org, t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH v2 2/6] rtc: omap: Add external clock enabling support
In-Reply-To: <1439198906-31189-3-git-send-email-j-keerthy@ti.com>
Message-ID: <alpine.DEB.2.02.1508121422020.7154@utopia.booyaka.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-3-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, 10 Aug 2015, Keerthy wrote:

> Switch to external clock source during suspend and switch back
> to internal source on resume. This helps rtc ticking across suspend.

Doesn't this type of dynamic switching make it likely that ticks will be 
lost?

If the external, optional source is present, isn't it best just to use the 
external source 100% of the time?


- Paul
