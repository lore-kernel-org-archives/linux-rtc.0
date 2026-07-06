Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880244213C;
	Mon,  6 Jul 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332648; cv=none; b=BuB+QXiMlHUQaKj2UvlSJ3BVrOKWiRqeaN+xQOlvqWyPv20rEITB+Hhv54Xuz26rxzYGg7e/s9KSaGmxXCCbSLWr6ogbSFlTmH4Y0AA9XVm+pkIGU0s/AZ/GHwBVjaNUS0Cc7P5A4bhNAlYh0dPR0XEr/7s5jDhojgchjkYmtCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332648; c=relaxed/simple;
	bh=WLIwIV4GvCX3ucV5uyAb6toekaibko4A0uIwk9CdbO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a5bXn8Fugg5L5GDv4OIpeddwzM/22m3xXnfSzjyjdWDvG32mDm9BA76J5FshQ9/AWDhKHdByR2+tSnr/c7mZmo+axmTpmBdrPx1oQWpthZTgDQXo1HNXD+5SPkl985iUFMs7zdnSciHwKOnNtcFVUo6gBRq4zyAbG+P28Et7+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnsnxFZN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnsnxFZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9971F000E9;
	Mon,  6 Jul 2026 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332647;
	bh=WLIwIV4GvCX3ucV5uyAb6toekaibko4A0uIwk9CdbO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mnsnxFZNQHpf6/OiaIJhipA2sAVcZqZzTAI4IdyS0ip7r8CrrR5RUO9d8J8IlwAS/
	 ecBGXXL+LqfdrcJXNqviJd9tTPb7iaMYfSXFxseCq20nX4aNu3VuCxKL5lGnA9f5JQ
	 FMDvuIJCTVWKEbTRobLQ2vd3pKXr3wLlqAiszs9Of/gpM+VoequMxGNXkZpQi6VZxS
	 q3LECnGJg1BkZmH5j6adZJG53NsHWWgIg32oMb9gg9z9VumrPuAY/DRabST9XgImq6
	 joBO9BPEuspWPetI3qhhJ/vKF3t9rPTWo4HaEeqVknSh6tZVy6uW2MHILTDcuQ1k6N
	 0MH+/KVsgmu5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] clk: sunxi-ng: mux: remove unneeded export
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260706-a733-rtc-v4-7-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-7-f330728db3d3@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:10:46 +0000
Message-Id: <20260706101046.8B9971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The export ccu_mux_helper_apply_prediv() symbol is actually not
> necessary. No module other than sunxi-ccu would use it at the moment
> so just remove the export.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-a733-rtc-v=
4-0-f330728db3d3@baylibre.com?part=3D7

