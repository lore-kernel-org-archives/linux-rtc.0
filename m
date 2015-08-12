Return-Path: <rtc-linux+bncBDENZBE5PQIJHNNNVYCRUBGGAB5XW@googlegroups.com>
Received: from utopia.booyaka.com (utopia.booyaka.com. [74.50.51.50])
        by gmr-mx.google.com with ESMTPS id ax9si1502973igc.1.2015.08.12.07.39.13
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 07:39:13 -0700 (PDT)
Date: Wed, 12 Aug 2015 14:39:11 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Keerthy <j-keerthy@ti.com>
cc: tony@atomide.com, linux-omap@vger.kernel.org, pawel.moll@arm.com,
  galak@codeaurora.org, alexandre.belloni@free-electrons.com,
  akpm@linux-foundation.org, johan@kernel.org, grygorii.strashko@ti.com,
  rtc-linux@googlegroups.com, bcousson@baylibre.com, nm@ti.com,
  devicetree@vger.kernel.org, t-kristo@ti.com
Subject: [rtc-linux] Re: [PATCH v2 5/6] ARM: AM43XX: HWMOD: Add rtc hwmod
In-Reply-To: <1439198906-31189-6-git-send-email-j-keerthy@ti.com>
Message-ID: <alpine.DEB.2.02.1508121434190.7154@utopia.booyaka.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com> <1439198906-31189-6-git-send-email-j-keerthy@ti.com>
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

> The patch adds rtc hwmod. This is present on gp and sk evm and not on
> epos evm. Hence adding it selectively using a seprate list.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

So just to confirm, the RTC IP block has been physically removed or 
permanently disabled on these new AM438x chips?  So the registers are no 
longer accessible by the MPU?

Is there a TRM available for these chips?


- Paul
