Return-Path: <robh@kernel.org>
Date: Tue, 23 Feb 2016 17:29:18 -0600
From: Rob Herring <robh@kernel.org>
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:REAL TIME CLOCK RTC SUBSYSTEM" <rtc-linux@googlegroups.com>
Subject: Re: [PATCH v7] rtc: rewrite DS1302 using SPI
Message-ID: <20160223232918.GA16024@rob-hp-laptop>
References: <1456105286-28598-1-git-send-email-ynvich@gmail.com>
 <1456224900-4877-1-git-send-email-ynvich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456224900-4877-1-git-send-email-ynvich@gmail.com>
List-ID: <rtc-linux.googlegroups.com>

On Tue, Feb 23, 2016 at 01:54:57PM +0300, Sergei Ianovich wrote:
> DS1302 is half-duplex SPI device. The driver respects this fact now.
> 
> Pin configurations should be implemented using SPI subsystem.
> 
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: Rob Herring <robh@kernel.org>
> 
>    v6..v7
>    * change binding and doc file names
> 
>    v5..v6
>    * rewrite the driver as an SPI slave device
>    * use "maxim" for vendor name per Kconfig
>    * stop changing device RAM in device presence test
>    * only return time from device if valid
>    * use burst mode for reading/writing time
>    * dropped charging control. I cannot test it, and it looks broken
> 
>    v4..v5
>    * drop THIS_MODULE from struct platform driver
>    * use "dallas" for vendor name per vendor-prefixes.txt
> 
>    v3..v4
>    * move DTS bindings to a different patch
> 
>    v2..v3
>    * use usleep_range instead of custom nsleep
>    * number change (07/16 -> 09/21)
> 
>    v0..v2
>    * use device tree
>    * use devm helpers where possible
> ---
>  .../devicetree/bindings/rtc/maxim-ds1302.txt       |  46 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/rtc/Kconfig                                |  15 +-
>  drivers/rtc/rtc-ds1302.c                           | 348 ++++++++++-----------
>  3 files changed, 212 insertions(+), 197 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
