Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769781;
	b=JT8qzIfKqZRBY8YnBtais+Ck5Ra0yvJvUr+jOhcFhDIyAH5T8EZnSpOz/QYjKjDTa6Gx
	 BNfXFIqnC52euO1uDnXFoZFHlAXogYET0Z8J5qVXGQcbFlb6OqWKmb5iLced3UqtJIqrc
	 d3X1PzpfdFzM9LZB1duNM+kXPHvXv2WtlKQU0TNb7kksX4TS/dYJJTLdcr61kCTkxOUZd
	 BqOQjm613ajiIVlgk+mWGrT4PbZSF0woritXbr9FUB6Fx1+UIxM8LiDK/I8SBx18PV54B
	 41tgslPgWwxC7vUvEa/nD+TgynZMbkQi7Ya1U4aqxKRMeqJslIDOA1OrD9CGLeXumvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ND6B4vyGm/ABSimDmg+H5/7Vt/AKFTwdEn34KGY2MHc=;
	b=p/nRIK7gKtlXXHnspoediUUSsKosC4TlxPm5jDezj9BoIZsfx54dy/1MPVBi2n3zLOw0
	 +s5Mzia1ZC32WF9PbkLfUZXSZbLus3fjkj9dE67Tp6yq+FzjXSw1NAXWXmyqK1LrrRFvm
	 v1zrAQ7CK2a1tVXyw0lpeLaW/zd2p+PmczryYq5uSASKHshcJQdefGsN4UqJslzOcKHzN
	 FbUk5cgx7/pkz+IR31uWcEliwP4ctQrCgPC6nuaAoDeyeB8pQoULCSwh+HNu/NrjEGyW1
	 rH0Aa++2Xeb7o5RoVHY8H6wmGUFo2AMcpFRSj9qISGHTkrCUhhJsuVyDIIgJC48IFxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEMer1av;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC7606A32A;
	Fri, 27 Nov 2026 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEMer1av
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0001F000C1;
	Fri, 27 Nov 2026 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795769781;
	bh=ND6B4vyGm/ABSimDmg+H5/7Vt/AKFTwdEn34KGY2MHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JEMer1avNWrpXEjEvImIOUuyT+z6HTKZETC3US6lBIHIlLOj6/XZ/o//MfDCmtawZ
	 znkS+J4JZ9BGxxQhgAXx23fgvNMF58Bfzi6hg7pkNgj3ZUwNGFR39C7aNM6lzMmxM+
	 7/XpB8Tsui5axukBrDaxe6p9JgTt2y3eQ4ROTPDiTdtH2vllJNa3WJyKjHaYY7W5yD
	 h7xQ5aVl1njPv6JFquQ39QOfSa5wxJ8Ssp2snglR6jdhrAvjHt5vzBeqpXjJiGcK90
	 lVe98yGjhjvYmy8Yt/0XCLQLeX8qm8nJhYy1XM9RdfTnalpOyRGAbAi8gUAMCHLqJs
	 Z8yi8lwc3NJDw==
Message-ID: <sashiko-outbox-236927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 0/4] rtc: Add NXP PCF8525 RTC support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
References: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:56:20 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 4-patch series:

- Patches 1, 3, and 4: no issues found.
- Patch 2 ("rtc: pcf8525: Add NXP PCF8525 RTC driver"): 1 potential
  issue (1 Medium)

A detailed review has been sent as a separate reply to patch 2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127083807.2844=
507-1-shivprakash.gupta@nxp.com
