Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483246;
	b=PVap/0/RPvth7MlHOEB8iJOdcWi8SazRz3tcWnwrmtO/9ho3ekO8vg7zCMTYOUZJ9t+Y
	 vnJOA/HvVx+OyEDNn6GZCv/cfynB3KSH0QX7VnUlo5DTKCrIxIjtFHd8jNG3u/8IAnu7M
	 5M4RZKPdMm6jwE1rOKmO7G7Q2Hi7WF5w9pMaYuSk3i+jfyhy2/DkpnLCManOcParm15y0
	 fiaihRwlJ7Ar1jpN5aPisADJwIHlrM/bxh1zj5GUm4yleCGWjuoHzmLs1PnNqkL8XFCHf
	 iZiv4pHJHeey1pq8SbBWdzDSotE/moPmPYc31uKv0Ilf0qRZo/G3d+cQ+7ss9eLaWow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483246;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l0kO4ETdfhR55VCNdjrAI5aXKIK9Djys/9OXJzeZMYY=;
	b=gYZ9PPWAvtDuiKUInJfs7C+pJoLZBk3hmMGvt5JJLhkpin7+vXUqG4Z67gyU3Jffvil7
	 86ADIfEywqeLriIQ5LMWch+Coa0aq0+LIevbuXpekeCUH9ovOozFy+lwjkW9Fb6a9Ul+2
	 eCYcKXfNH1S2BSI0AMZf2LN/gKt4jKWvlhsX4WffsETNp/wXOe0QlGgrDz88NUSo2Pg2O
	 I7H2pbTpkCoxNDzasCzGbYO+dte39iFOWlIvWk6wJhYquLxf74Fv0idinVQV0/pIS1Zfh
	 0TgrOxxYQ1cg4Ao+6A1zKSNV2NujZ7qw7fUAnrlRqEP5MZOdy7+/H+nCIpU6pH6EmVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Si/sdo+P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113D606A31D;
	Tue, 20 Oct 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Si/sdo+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFE01F000C4;
	Tue, 20 Oct 2026 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483246;
	bh=l0kO4ETdfhR55VCNdjrAI5aXKIK9Djys/9OXJzeZMYY=;
	h=From:To:Cc:Subject:Date;
	b=Si/sdo+PgPNuzVm/YjolRPCbuEFkDJfz+KJLgkRW4n33E6IshUOD3ln3yfN0PoXIH
	 K1omi3AM16MTgu06Dgg4simGghVeUWDqrtE4I3kG578KDtmMx4C+1lLMFwXHHEa/2I
	 wtN4mS0JwXVgOGAHaAv7AlPc5sdNT6BynR3701qSo1+uo0G4PWSk4t7pFpD7jjg3kc
	 KGb+l1cr0HDyKuApJVWnvOqSL18wGzSuhCmKExRWCbXcwAuYJbhRjpvalevqaxk1dW
	 O7BdjokD0avegCiFomfj0aMXCR5i43ZKTfwtS05nVwX+ULL7ln3N+cXZShLxKPFxha
	 ST5B/9fqIA+3w==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Date: Tue, 20 Oct 2026 09:59:21 +0200
Message-ID: <20261020080026.2461578-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

The RTC_HCTOSYS feature faces an impossible dilemma on 32-bit systems:

 a) systemd requires RTC_HCTOSYS=y with the correct timestamp
    for its intended operation

 b) broken RTC hardware can produce random future timestamps
    beyond 2038 at boot time

 c) time32 userspace immediately hangs if the time is set to a
    date beyond 2038 and requires timestamps to be clamped

 d) time64 userspace is intended to survive the actual 2038
    date and requires timestamps to not be clamped

Commit b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow
time_t") introduced this limit to protect time32 userspace from future
RTC dates that can break boot and address constraints a), b) and c),
but broke d) in the process by limiting RTC_HCTOSYS to the time32 range
and falling back to RTC_HCTOSYS=n behavior when the RTC time overflows
that.

Make the behavior configurable with a new RTC_HCTOSYS_TIME32_LIMIT
option that chooses between breaking c) or d). On systems with
COMPAT_32BIT_TIME=n, only RTC_HCTOSYS_TIME32_LIMIT=n is allowed since
userspace can be assumed to be fully built for time64. 64-bit kernels
running 32-bit userland never had the cutoff and continue to not offer
the option.

Warn on rejection with the RTC date and option name so users can
identify the cause and find the setting.

[arnd: reword Kconfig text and patch description,
       add COMPAT_32BIT_TIME dependency]
Fixes: b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow time_t")
Link: https://lore.kernel.org/all/20220908115337.1604277-1-arnd@kernel.org/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
I ended up rewriting most of the text but kept Karl's ownership
as he did the original patch.
---
 drivers/rtc/Kconfig | 21 +++++++++++++++++++++
 drivers/rtc/class.c |  8 +++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8d9f4ef92f5a..9b6b0c31eb8e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -30,6 +30,27 @@ config RTC_HCTOSYS
 	  the value read from a specified RTC device. This is useful to avoid
 	  unnecessary fsck runs at boot time, and to network better.
 
+config RTC_HCTOSYS_TIME32_LIMIT
+	bool "Reject RTC dates after the 2038 cutoff"
+	depends on RTC_HCTOSYS && COMPAT_32BIT_TIME && !64BIT
+	default y
+	help
+	  Reject RTC dates after 03:14:07 UTC on 19 January 2038 when
+	  initializing the system clock in order to work around broken
+	  RTC implementations that produce nondeterministic timestamps
+	  without a working backup battery.
+
+	  A rejected date leaves system time unchanged, normally near
+	  the Unix epoch, and the RTC's hctosys sysfs attribute reads
+	  0. Userspace must supply the time if no other source has
+	  initialized it.
+
+	  Say Y here if the kernel may have to run old time32 userspace on
+	  hardware that can produce unpredictable RTC timestamps.  If the
+	  kernel is intended to only run time64 compatible userspace and
+	  continue working past 2038, you must pick N here in order to
+	  have a working RTC_HCTOSYS functionality.
+
 config RTC_HCTOSYS_DEVICE
 	string "RTC used to set the system time"
 	depends on RTC_HCTOSYS
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 01ba04028f1f..18ea141ab8c2 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -72,12 +72,14 @@ static void rtc_hctosys(struct rtc_device *rtc)
 
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
 
-#if BITS_PER_LONG == 32
-	if (tv64.tv_sec > INT_MAX) {
+	if (IS_ENABLED(CONFIG_RTC_HCTOSYS_TIME32_LIMIT) &&
+	    tv64.tv_sec > INT_MAX) {
+		dev_warn(rtc->dev.parent,
+			 "hctosys: rejecting %ptR UTC due to CONFIG_RTC_HCTOSYS_TIME32_LIMIT=y\n",
+			 &tm);
 		err = -ERANGE;
 		goto err_read;
 	}
-#endif
 
 	err = do_settimeofday64(&tv64);
 
-- 
2.53.0

