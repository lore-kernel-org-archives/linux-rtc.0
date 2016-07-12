Return-Path: <rtc-linux+bncBCEPJZEDQIBBBJV5SS6AKGQECI3C6FA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ducie-dc1.codethink.co.uk (ducie-dc1.codethink.co.uk. [185.25.241.215])
        by gmr-mx.google.com with ESMTPS id 65si162931wmr.3.2016.07.12.09.45.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2016 09:45:25 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 0/2] AMLogic Meson SoC RTC driver
To: Kevin Hilman <khilman@baylibre.com>
References: <1467748089-14718-1-git-send-email-ben.dooks@codethink.co.uk>
 <7hinwg85k7.fsf@baylibre.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-amlogic@lists.infradead.org,
 rtc-linux@googlegroups.com, a.zummo@towertech.it, narmstrong@baylibre.com,
 devicetree@vger.kernel.org, alexandre.belloni@free-electrons.com,
 frowand.list@gmail.com
From: Ben Dooks <ben.dooks@codethink.co.uk>
Message-ID: <53016146-6647-224c-ba1a-f2a9dc364a86@codethink.co.uk>
Date: Tue, 12 Jul 2016 17:45:22 +0100
MIME-Version: 1.0
In-Reply-To: <7hinwg85k7.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 08/07/16 17:20, Kevin Hilman wrote:
> Ben Dooks <ben.dooks@codethink.co.uk> writes:
> 
>> This series adds support for the on SoC RTC driver on the
>> AMLogic Meson devices.
> 
> -ECONFUSED
> 
> In reply to this patch, there are two other "PATCH v3 0/2" replies, an
> then the two patches themselves, have "PATCH n/4" subjects when one
> would expect "PATCH n/2" subjects.

This was my mistake of formatting the patch then thinking it would
be easy to remove the other two patches I decided to keep separate
(for reasons below)

> Anyways, I was able to test this version with the DTs from the previous
> version, and it works ok.

Yes, no changes for the DT bits so I decided to remove them as firstly
they depend on the reset-controller changes going in and secondly
the rtc driver part doesn't need them to be there to be able to build.

> Can you respin one more time (including the Tested-by) so the RTC
> maintainers can pick it up?

I'll do that now and try and post them tonight.
Thankyou for testing.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
