Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB4WFQLDAKGQEJAN4GDY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id n128si880389wmf.2.2017.03.08.16.33.54
        for <rtc-linux@googlegroups.com>;
        Wed, 08 Mar 2017 16:33:54 -0800 (PST)
Date: Thu, 9 Mar 2017 01:33:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv4 1/2] dt-bindings: Add vendor prefix for Motorola
Message-ID: <20170309003354.ueodnxio446ps6vp@piout.net>
References: <20170220073535.27393-1-sre@kernel.org>
 <20170302002709.22276-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170302002709.22276-1-sre@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/03/2017 at 01:27:08 +0100, Sebastian Reichel wrote:
> Motorola was involved in semiconductor and mobile phone business.
> The "motorola," prefix is already used by a couple of bindings:
> 
> * rtc/rtc-cmos.txt
> * mfd/motorola-cpcap.txt
> * regulator/cpcap-regulator.txt
> 
> Apart from that it is used in the DT file for the Droid 4 mobile
> phone.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv3:
>  - Fix typo
>  - Add Acked-By from Rob Herring
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

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
