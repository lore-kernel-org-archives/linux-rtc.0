Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426201;
	b=e4l/2VPj1ER1fac4ggTfBZEn6dz6hRcNkmmrxM9wy3rGpPoqa6n7brtdPWZldSdC1oMv
	 Se5ZwuLUWb83pNCioO6G5ivjDkJKfQDxrYoLZYrs0+YEc1gKENLCjRkR8Qxtg4GjYStF6
	 ifujIWN0I1LPF0118wTkWxH+BvW2EXj2lxoUffkxFtx8cq5aWdtjXsGG5R6896nAq/SCZ
	 yhaDDDazl7Y9XIEF8eoJA7x23Bf9lmCwlEHEoqHVdVuhCtBh4SJNVt6VM5HR5bEOpgHju
	 r92ozm69YJODVvrp9gTtWqaeMbPlIWHcar0E8Ck54iBIzm/7bHxTfYTAMUZ+gBVyxgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426201;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s0dJf/K+n44jMWbzlUzq0T6IzL3g9Gh5bmxMkaX4JLc=;
	b=Lk3rKjow7NEacudGvE1VZt94LQXNlnufAdRR6K79ZEyxOfmNLMVb/NFCCjF7uO0sy2AJ
	 tSnJa2O/23KYKBFVRaVj3qiS6VXkqWeICEM1yGmFSck/Y0a2Vuymcvrbrse+l/mjeKXTn
	 K47tqXir2MAolUIOxYnKusEq2gGVRCIgN4X9qrjbwptOV/PKAll3Gz5z8+ZBAPuGc6Kp0
	 CyR23DgHuAkogGxKvhm+DoFgVFCsPDcJi+liaq+u9NewB2H8kjKdEtN1MwTg0P9+h/n5b
	 fnILw7TCUvgjmne8ipXeSh1/aAnQ3wN60ROh0nP78slVphxf1CZx/B0BeGwcUfLdkNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bv81JGWe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C67606A31E
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bv81JGWe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB261F000C5;
	Mon, 19 Oct 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426200;
	bh=s0dJf/K+n44jMWbzlUzq0T6IzL3g9Gh5bmxMkaX4JLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bv81JGWev/nBRVJ2Iwav9hI2e0K+nvg4sbMZHgVc4tIVy9sYbv+C6C/t7WE9wus5J
	 B4kaZ3AfIiD/OC/613ch256yyo5jAljdbWjyCFcWAWumwcn+OF6PtE34xgTnwopAIE
	 Kv/hGRtjyIwmsY1bsWGK4vRI885c7Qm0NgJTRPpVdqL6ysPjCX5LvamC06k+5FglN+
	 977xqfxqWb1xtYyHSR6WBNGhPL5gsUUD7/akmaeHqR6x1OVkOrOT4jLi7Cic8VwTXo
	 doXYYo3G9ltrBM/lsIfn0AXCTPQ2oiM8qtPYoZ7E1D0siMB0ee1zpN2JJC6EABj/Lu
	 tJCdiF325JvEQ==
Message-ID: <sashiko-outbox-177817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: mpfs: Fix alarm register word order
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFlayBLeXUsIEtpbQ==?= <pocj8ur4in@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261019151024.2232338-1-pocj8ur4in@gmail.com>
References: <20261019151024.2232338-1-pocj8ur4in@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:10:00 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> mpfs_rtc_readalarm() swaps the low and high words of the alarm time.
> The RTC core reads this value during device registration to initialize
> its alarm timer. This can populate the cached alarm and timer queue
> with an incorrect expiry time, or leave an enabled hardware alarm out
> of the timer queue if the decoded time appears to be in the past.
>=20
> Read the low 32 bits from ALARM_LOWER_REG and place the masked high
> 11 bits from ALARM_UPPER_REG in bits 42:32. This matches the layout
> used by mpfs_rtc_setalarm() and the low/high assembly in
> mpfs_rtc_readtime(), so the RTC core imports the programmed alarm
> time correctly during device registration.
>=20
> Fixes: 0b31d703598d ("rtc: Add driver for Microchip PolarFire SoC")
> Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019151024.2232=
338-1-pocj8ur4in@gmail.com?part=3D1

