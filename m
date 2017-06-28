Return-Path: <rtc-linux+bncBDJIP47K7MERBRW7Z7FAKGQEDABBHHQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com. [209.85.223.196])
        by gmr-mx.google.com with ESMTPS id 199si161438itz.4.2017.06.28.11.04.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 11:04:54 -0700 (PDT)
Received: by mail-io0-f196.google.com with SMTP id j200so5919154ioe.0
        for <rtc-linux@googlegroups.com>; Wed, 28 Jun 2017 11:04:54 -0700 (PDT)
Date: Wed, 28 Jun 2017 13:04:52 -0500
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/2] dt-bindings: rtc: stm32: add support for STM32H7
Message-ID: <20170628180452.rdvnul7cifxglu7f@rob-hp-laptop>
References: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
 <1498470689-26829-2-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1498470689-26829-2-git-send-email-amelie.delaunay@st.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Jun 26, 2017 at 11:51:28AM +0200, Amelie Delaunay wrote:
> This patch documents support for STM32H7 Real Time Clock.
> It introduces a new compatible and rework clock definitions.
> On STM32H7 we have a 'pclk' clock for register access, in addition to
> the 'rtc_ck' clock.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 ++++++++++++++++++----
>  1 file changed, 27 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
