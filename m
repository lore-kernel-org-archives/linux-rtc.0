Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE9D3AE1A0;
	Fri, 21 Aug 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306963; cv=none; b=bjWbZgml8Cc5VayV7UcqXHlO3pGTK7PrrY0y3uWSgR7f1tw5iGvTejNl7KThnJ5zh9C0/JjuGrQRM+RoFjzM3zUcqNFUHwSiW2A0sNwMuayq32Mo6YrBUYvC14T9P6vD9+xxsjlkTVOppDydA1Kbgg6H+8dnGfs7wJ3CK060/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306963; c=relaxed/simple;
	bh=Q1L0BVepiwdLEDZ9e2EvZ8Zj+U6zpdsvYbboIl417DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlmeaA0iuoJt3XOD+q+1kdwscbEygTeukWXWoDycEbK01l0fpt+sZyjoIefAX49in77czn/2weMDdxRcoEItF4lBQDzS7fJQ69UZfl83aVWokLzXRSzzjqn17yivkE3zBtYGl9TKXOG0nCIcxWVQ0Q34OA/hdhDNw1VImlaSeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFCD1F00A3A;
	Fri, 21 Aug 2026 10:09:10 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>
Cc: linux-rtc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/5] rtc: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:09:01 +0200
Message-ID: <cover.1787241693.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Hence this series aims to make sure all members are fully initialized,
to avoid such bugs, and to prevent future breakage when converting
drivers to a different method for specifying the parents.

Part One[1] fixed all cases that I identified to be real bugs, in
response to a crash I saw on BeagleBone Black.

This series is the RTC subpart of Part Two, which fixes remaining cases
that are currently harmless.  These are still fragile, and may cause
future breakage when converting drivers to a different method for
specifying the parents.

Thanks for your comments!

[1] "[PATCH treewide 0/5] clk: Make sure clk_init_data is fully
     initialized (part 1)"
    https://lore.kernel.org/cover.1787165329.git.geert+renesas@glider.be

Geert Uytterhoeven (5):
  rtc: hym8563: Make sure clk_init_data is fully initialized
  rtc: m41t80: Make sure clk_init_data is fully initialized
  rtc: nct3018y: Make sure clk_init_data is fully initialized
  rtc: philips: Make sure clk_init_data is fully initialized
  rtc: microcrystal: Make sure clk_init_data is fully initialized

 drivers/rtc/rtc-hym8563.c  | 2 +-
 drivers/rtc/rtc-m41t80.c   | 2 +-
 drivers/rtc/rtc-nct3018y.c | 2 +-
 drivers/rtc/rtc-pcf85063.c | 2 +-
 drivers/rtc/rtc-pcf8563.c  | 2 +-
 drivers/rtc/rtc-rv3028.c   | 2 +-
 drivers/rtc/rtc-rv3032.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
